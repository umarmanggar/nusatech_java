package util;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

/**
 * Utility class for handling file uploads
 * Provides methods for uploading, validating, and deleting files
 * 
 * @author NusaTech
 */
public class FileUploadUtil {
    
    // Configuration constants
    private static final String UPLOAD_BASE_DIR = "uploads";
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final long MAX_IMAGE_SIZE = 2 * 1024 * 1024; // 2MB for images
    private static final long MAX_VIDEO_SIZE = 100 * 1024 * 1024; // 100MB for videos
    private static final long MAX_DOCUMENT_SIZE = 10 * 1024 * 1024; // 10MB for documents
    
    // Allowed file types
    private static final List<String> ALLOWED_IMAGE_TYPES = Arrays.asList(
        "image/jpeg", "image/jpg", "image/png", "image/gif", "image/webp"
    );
    
    private static final List<String> ALLOWED_IMAGE_EXTENSIONS = Arrays.asList(
        ".jpg", ".jpeg", ".png", ".gif", ".webp"
    );
    
    private static final List<String> ALLOWED_DOCUMENT_TYPES = Arrays.asList(
        "application/pdf", 
        "application/msword",
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        "application/vnd.ms-powerpoint",
        "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    );
    
    private static final List<String> ALLOWED_DOCUMENT_EXTENSIONS = Arrays.asList(
        ".pdf", ".doc", ".docx", ".ppt", ".pptx"
    );
    
    private static final List<String> ALLOWED_VIDEO_TYPES = Arrays.asList(
        "video/mp4", "video/webm", "video/ogg", "video/quicktime"
    );
    
    private static final List<String> ALLOWED_VIDEO_EXTENSIONS = Arrays.asList(
        ".mp4", ".webm", ".ogg", ".mov"
    );
    
    /**
     * Upload an image file
     * 
     * @param filePart The file part from multipart request
     * @param folder The subfolder to store the image (e.g., "courses", "profiles")
     * @return The filename of the uploaded file, or null if upload failed
     * @throws IOException If an I/O error occurs
     * @throws IllegalArgumentException If the file is invalid
     */
    public static String uploadImage(Part filePart, String folder) throws IOException, IllegalArgumentException {
        // Validate file
        if (filePart == null || filePart.getSize() == 0) {
            throw new IllegalArgumentException("File tidak boleh kosong");
        }
        
        // Validate file type
        if (!validateImageType(filePart)) {
            throw new IllegalArgumentException("Format file tidak didukung. Gunakan JPG, PNG, GIF, atau WebP");
        }
        
        // Validate file size
        if (!validateFileSize(filePart, MAX_IMAGE_SIZE)) {
            throw new IllegalArgumentException("Ukuran file terlalu besar. Maksimal 2MB untuk gambar");
        }
        
        return uploadFile(filePart, folder, "img");
    }
    
    /**
     * Upload a document file (PDF, DOC, DOCX, PPT, PPTX)
     * 
     * @param filePart The file part from multipart request
     * @param folder The subfolder to store the document
     * @return The filename of the uploaded file
     * @throws IOException If an I/O error occurs
     * @throws IllegalArgumentException If the file is invalid
     */
    public static String uploadDocument(Part filePart, String folder) throws IOException, IllegalArgumentException {
        if (filePart == null || filePart.getSize() == 0) {
            throw new IllegalArgumentException("File tidak boleh kosong");
        }
        
        if (!validateDocumentType(filePart)) {
            throw new IllegalArgumentException("Format file tidak didukung. Gunakan PDF, DOC, DOCX, PPT, atau PPTX");
        }
        
        if (!validateFileSize(filePart, MAX_DOCUMENT_SIZE)) {
            throw new IllegalArgumentException("Ukuran file terlalu besar. Maksimal 10MB untuk dokumen");
        }
        
        return uploadFile(filePart, folder, "doc");
    }
    
    /**
     * Upload a video file
     * 
     * @param filePart The file part from multipart request
     * @param folder The subfolder to store the video
     * @return The filename of the uploaded file
     * @throws IOException If an I/O error occurs
     * @throws IllegalArgumentException If the file is invalid
     */
    public static String uploadVideo(Part filePart, String folder) throws IOException, IllegalArgumentException {
        if (filePart == null || filePart.getSize() == 0) {
            throw new IllegalArgumentException("File tidak boleh kosong");
        }
        
        if (!validateVideoType(filePart)) {
            throw new IllegalArgumentException("Format file tidak didukung. Gunakan MP4, WebM, OGG, atau MOV");
        }
        
        if (!validateFileSize(filePart, MAX_VIDEO_SIZE)) {
            throw new IllegalArgumentException("Ukuran file terlalu besar. Maksimal 100MB untuk video");
        }
        
        return uploadFile(filePart, folder, "vid");
    }
    
    /**
     * Generic file upload method
     * 
     * @param filePart The file part from multipart request
     * @param folder The subfolder to store the file
     * @param prefix Prefix for the generated filename
     * @return The filename of the uploaded file
     * @throws IOException If an I/O error occurs
     */
    private static String uploadFile(Part filePart, String folder, String prefix) throws IOException {
        // Get original filename and extension
        String originalFilename = getSubmittedFileName(filePart);
        String extension = getFileExtension(originalFilename);
        
        // Generate unique filename
        String filename = prefix + "_" + UUID.randomUUID().toString() + extension;
        
        // Create upload directory if not exists
        String uploadPath = getUploadPath(folder);
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // Save file
        Path filePath = Paths.get(uploadPath, filename);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
        }
        
        // Return relative path
        return folder + "/" + filename;
    }
    
    /**
     * Delete a file
     * 
     * @param relativePath The relative path of the file to delete
     * @return true if file was deleted, false otherwise
     */
    public static boolean deleteFile(String relativePath) {
        if (relativePath == null || relativePath.isEmpty()) {
            return false;
        }
        
        try {
            // Remove leading slash if present
            if (relativePath.startsWith("/")) {
                relativePath = relativePath.substring(1);
            }
            
            String fullPath = getUploadBasePath() + File.separator + relativePath;
            File file = new File(fullPath);
            
            if (file.exists() && file.isFile()) {
                return file.delete();
            }
            
            return false;
        } catch (Exception e) {
            System.err.println("Error deleting file: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Validate if file is an image
     * 
     * @param filePart The file part to validate
     * @return true if file is a valid image type
     */
    public static boolean validateImageType(Part filePart) {
        if (filePart == null) {
            return false;
        }
        
        String contentType = filePart.getContentType();
        String filename = getSubmittedFileName(filePart);
        String extension = getFileExtension(filename).toLowerCase();
        
        return ALLOWED_IMAGE_TYPES.contains(contentType) || 
               ALLOWED_IMAGE_EXTENSIONS.contains(extension);
    }
    
    /**
     * Validate if file is a document
     * 
     * @param filePart The file part to validate
     * @return true if file is a valid document type
     */
    public static boolean validateDocumentType(Part filePart) {
        if (filePart == null) {
            return false;
        }
        
        String contentType = filePart.getContentType();
        String filename = getSubmittedFileName(filePart);
        String extension = getFileExtension(filename).toLowerCase();
        
        return ALLOWED_DOCUMENT_TYPES.contains(contentType) || 
               ALLOWED_DOCUMENT_EXTENSIONS.contains(extension);
    }
    
    /**
     * Validate if file is a video
     * 
     * @param filePart The file part to validate
     * @return true if file is a valid video type
     */
    public static boolean validateVideoType(Part filePart) {
        if (filePart == null) {
            return false;
        }
        
        String contentType = filePart.getContentType();
        String filename = getSubmittedFileName(filePart);
        String extension = getFileExtension(filename).toLowerCase();
        
        return ALLOWED_VIDEO_TYPES.contains(contentType) || 
               ALLOWED_VIDEO_EXTENSIONS.contains(extension);
    }
    
    /**
     * Validate file size
     * 
     * @param filePart The file part to validate
     * @param maxSize Maximum allowed size in bytes
     * @return true if file size is within limit
     */
    public static boolean validateFileSize(Part filePart, long maxSize) {
        if (filePart == null) {
            return false;
        }
        return filePart.getSize() <= maxSize;
    }
    
    /**
     * Validate file size using default max size
     * 
     * @param filePart The file part to validate
     * @return true if file size is within default limit
     */
    public static boolean validateFileSize(Part filePart) {
        return validateFileSize(filePart, MAX_FILE_SIZE);
    }
    
    /**
     * Get the submitted filename from Part
     * 
     * @param part The file part
     * @return The original filename
     */
    public static String getSubmittedFileName(Part part) {
        if (part == null) {
            return "";
        }
        
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String content : contentDisposition.split(";")) {
                if (content.trim().startsWith("filename")) {
                    String filename = content.substring(content.indexOf("=") + 1).trim();
                    // Remove quotes if present
                    if (filename.startsWith("\"") && filename.endsWith("\"")) {
                        filename = filename.substring(1, filename.length() - 1);
                    }
                    return filename;
                }
            }
        }
        return "";
    }
    
    /**
     * Get file extension from filename
     * 
     * @param filename The filename
     * @return The file extension (including dot)
     */
    public static String getFileExtension(String filename) {
        if (filename == null || filename.isEmpty()) {
            return "";
        }
        
        int lastDot = filename.lastIndexOf('.');
        if (lastDot > 0) {
            return filename.substring(lastDot);
        }
        return "";
    }
    
    /**
     * Get base upload path
     * 
     * @return The base upload path
     */
    public static String getUploadBasePath() {
        // You can configure this via system property or environment variable
        String basePath = System.getProperty("upload.base.path");
        if (basePath == null || basePath.isEmpty()) {
            basePath = System.getProperty("catalina.base") + File.separator + "webapps" + File.separator + UPLOAD_BASE_DIR;
        }
        return basePath;
    }
    
    /**
     * Get upload path for a specific folder
     * 
     * @param folder The subfolder name
     * @return The full upload path
     */
    public static String getUploadPath(String folder) {
        return getUploadBasePath() + File.separator + folder;
    }
    
    /**
     * Get the URL path for an uploaded file
     * 
     * @param relativePath The relative path of the file
     * @return The URL path to access the file
     */
    public static String getFileUrl(String relativePath) {
        if (relativePath == null || relativePath.isEmpty()) {
            return "";
        }
        return "/" + UPLOAD_BASE_DIR + "/" + relativePath;
    }
    
    /**
     * Check if a file exists
     * 
     * @param relativePath The relative path of the file
     * @return true if file exists
     */
    public static boolean fileExists(String relativePath) {
        if (relativePath == null || relativePath.isEmpty()) {
            return false;
        }
        
        String fullPath = getUploadBasePath() + File.separator + relativePath;
        File file = new File(fullPath);
        return file.exists() && file.isFile();
    }
    
    /**
     * Get human-readable file size
     * 
     * @param size Size in bytes
     * @return Human-readable size string
     */
    public static String getReadableFileSize(long size) {
        if (size <= 0) return "0 B";
        
        final String[] units = {"B", "KB", "MB", "GB", "TB"};
        int digitGroups = (int) (Math.log10(size) / Math.log10(1024));
        
        return String.format("%.1f %s", size / Math.pow(1024, digitGroups), units[digitGroups]);
    }
    
    /**
     * Sanitize filename to prevent directory traversal attacks
     * 
     * @param filename The original filename
     * @return Sanitized filename
     */
    public static String sanitizeFilename(String filename) {
        if (filename == null || filename.isEmpty()) {
            return "";
        }
        
        // Remove path separators and special characters
        return filename.replaceAll("[^a-zA-Z0-9._-]", "_");
    }
}

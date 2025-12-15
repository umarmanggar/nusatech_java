-- Fix Passwords for NusaTech
-- Jalankan ini setelah import nusatech.sql dan sample-data.sql
-- Password baru: 123456 (untuk semua user)

USE nusatech;

-- Password "123456" dengan SHA-256 + salt format
-- Format: base64(salt):base64(hash)
-- Salt: "nusatechsalt1234" (16 bytes)
-- Hash: SHA-256("nusatechsalt1234" + "123456")

-- Update semua password user ke "123456"
UPDATE users SET password = 'bnVzYXRlY2hzYWx0MTIzNA==:vLHdWKqZ+YrXlDqHd7bot4ij4V4jdPLzqvGNzuAHmRk=' WHERE user_id = 1;
UPDATE users SET password = 'bnVzYXRlY2hzYWx0MTIzNA==:vLHdWKqZ+YrXlDqHd7bot4ij4V4jdPLzqvGNzuAHmRk=' WHERE user_id = 2;
UPDATE users SET password = 'bnVzYXRlY2hzYWx0MTIzNA==:vLHdWKqZ+YrXlDqHd7bot4ij4V4jdPLzqvGNzuAHmRk=' WHERE user_id = 3;
UPDATE users SET password = 'bnVzYXRlY2hzYWx0MTIzNA==:vLHdWKqZ+YrXlDqHd7bot4ij4V4jdPLzqvGNzuAHmRk=' WHERE user_id = 4;
UPDATE users SET password = 'bnVzYXRlY2hzYWx0MTIzNA==:vLHdWKqZ+YrXlDqHd7bot4ij4V4jdPLzqvGNzuAHmRk=' WHERE user_id = 5;
UPDATE users SET password = 'bnVzYXRlY2hzYWx0MTIzNA==:vLHdWKqZ+YrXlDqHd7bot4ij4V4jdPLzqvGNzuAHmRk=' WHERE user_id = 6;
UPDATE users SET password = 'bnVzYXRlY2hzYWx0MTIzNA==:vLHdWKqZ+YrXlDqHd7bot4ij4V4jdPLzqvGNzuAHmRk=' WHERE user_id = 7;
UPDATE users SET password = 'bnVzYXRlY2hzYWx0MTIzNA==:vLHdWKqZ+YrXlDqHd7bot4ij4V4jdPLzqvGNzuAHmRk=' WHERE user_id = 8;
UPDATE users SET password = 'bnVzYXRlY2hzYWx0MTIzNA==:vLHdWKqZ+YrXlDqHd7bot4ij4V4jdPLzqvGNzuAHmRk=' WHERE user_id = 9;

SELECT 'Password berhasil diupdate! Password baru: 123456' AS status;
SELECT user_id, email, name, role FROM users;

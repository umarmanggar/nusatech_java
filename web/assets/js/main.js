/**
 * NusaTech - Main JavaScript Utilities
 * @author NusaTech
 * @version 1.0.0
 */

(function() {
    'use strict';

    // ==================== Configuration ====================
    const CONFIG = {
        toastDuration: 3000,
        animationDuration: 300,
        debounceDelay: 300,
        apiTimeout: 30000
    };

    // ==================== Toast Notifications ====================
    const Toast = {
        container: null,

        /**
         * Initialize toast container
         */
        init() {
            if (this.container) return;
            
            this.container = document.createElement('div');
            this.container.id = 'toast-container';
            this.container.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 9999;
                display: flex;
                flex-direction: column;
                gap: 10px;
                max-width: 350px;
            `;
            document.body.appendChild(this.container);
        },

        /**
         * Show toast notification
         * @param {string} message - Toast message
         * @param {string} type - Toast type: 'success', 'error', 'warning', 'info'
         * @param {number} duration - Duration in milliseconds
         */
        show(message, type = 'info', duration = CONFIG.toastDuration) {
            this.init();

            const toast = document.createElement('div');
            toast.className = `toast-notification toast-${type}`;
            
            const icons = {
                success: 'fa-check-circle',
                error: 'fa-exclamation-circle',
                warning: 'fa-exclamation-triangle',
                info: 'fa-info-circle'
            };

            const colors = {
                success: { bg: '#10b981', border: '#059669' },
                error: { bg: '#ef4444', border: '#dc2626' },
                warning: { bg: '#f59e0b', border: '#d97706' },
                info: { bg: '#3b82f6', border: '#2563eb' }
            };

            const color = colors[type] || colors.info;
            
            toast.innerHTML = `
                <i class="fas ${icons[type] || icons.info}"></i>
                <span class="toast-message">${message}</span>
                <button class="toast-close" onclick="NusaTech.Toast.close(this.parentElement)">
                    <i class="fas fa-times"></i>
                </button>
            `;

            toast.style.cssText = `
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 14px 16px;
                background: ${color.bg};
                color: white;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                border-left: 4px solid ${color.border};
                animation: slideIn 0.3s ease-out;
                font-size: 14px;
            `;

            // Add styles for close button
            const style = document.createElement('style');
            style.textContent = `
                @keyframes slideIn {
                    from { transform: translateX(100%); opacity: 0; }
                    to { transform: translateX(0); opacity: 1; }
                }
                @keyframes slideOut {
                    from { transform: translateX(0); opacity: 1; }
                    to { transform: translateX(100%); opacity: 0; }
                }
                .toast-close {
                    background: transparent;
                    border: none;
                    color: white;
                    cursor: pointer;
                    padding: 4px;
                    margin-left: auto;
                    opacity: 0.7;
                    transition: opacity 0.2s;
                }
                .toast-close:hover {
                    opacity: 1;
                }
                .toast-message {
                    flex: 1;
                }
            `;
            if (!document.getElementById('toast-styles')) {
                style.id = 'toast-styles';
                document.head.appendChild(style);
            }

            this.container.appendChild(toast);

            // Auto remove
            if (duration > 0) {
                setTimeout(() => this.close(toast), duration);
            }

            return toast;
        },

        /**
         * Close toast
         * @param {HTMLElement} toast - Toast element
         */
        close(toast) {
            if (!toast || !toast.parentElement) return;
            
            toast.style.animation = 'slideOut 0.3s ease-in forwards';
            setTimeout(() => {
                if (toast.parentElement) {
                    toast.parentElement.removeChild(toast);
                }
            }, 300);
        },

        // Shorthand methods
        success(message, duration) { return this.show(message, 'success', duration); },
        error(message, duration) { return this.show(message, 'error', duration); },
        warning(message, duration) { return this.show(message, 'warning', duration); },
        info(message, duration) { return this.show(message, 'info', duration); }
    };

    // ==================== Confirm Dialogs ====================
    const Confirm = {
        /**
         * Show confirmation dialog
         * @param {Object} options - Dialog options
         * @returns {Promise<boolean>}
         */
        show(options = {}) {
            return new Promise((resolve) => {
                const {
                    title = 'Konfirmasi',
                    message = 'Apakah Anda yakin?',
                    confirmText = 'Ya',
                    cancelText = 'Batal',
                    type = 'default', // 'default', 'danger', 'warning'
                    icon = null
                } = options;

                const overlay = document.createElement('div');
                overlay.className = 'confirm-overlay';
                overlay.style.cssText = `
                    position: fixed;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: rgba(0, 0, 0, 0.5);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    z-index: 10000;
                    animation: fadeIn 0.2s ease-out;
                `;

                const colors = {
                    default: '#8B1538',
                    danger: '#ef4444',
                    warning: '#f59e0b'
                };

                const icons = {
                    default: 'fa-question-circle',
                    danger: 'fa-exclamation-triangle',
                    warning: 'fa-exclamation-circle'
                };

                const dialogIcon = icon || icons[type] || icons.default;
                const buttonColor = colors[type] || colors.default;

                overlay.innerHTML = `
                    <div class="confirm-dialog" style="
                        background: white;
                        border-radius: 16px;
                        padding: 30px;
                        max-width: 400px;
                        width: 90%;
                        text-align: center;
                        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
                        animation: scaleIn 0.2s ease-out;
                    ">
                        <div class="confirm-icon" style="
                            width: 70px;
                            height: 70px;
                            border-radius: 50%;
                            background: ${buttonColor}15;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            margin: 0 auto 20px;
                        ">
                            <i class="fas ${dialogIcon}" style="font-size: 32px; color: ${buttonColor};"></i>
                        </div>
                        <h4 style="margin: 0 0 10px; color: #1f2937; font-size: 20px;">${title}</h4>
                        <p style="margin: 0 0 25px; color: #6b7280; line-height: 1.6;">${message}</p>
                        <div style="display: flex; gap: 12px; justify-content: center;">
                            <button class="confirm-cancel" style="
                                padding: 12px 24px;
                                border: 1px solid #e5e7eb;
                                background: white;
                                color: #374151;
                                border-radius: 8px;
                                font-weight: 600;
                                cursor: pointer;
                                transition: all 0.2s;
                            ">${cancelText}</button>
                            <button class="confirm-ok" style="
                                padding: 12px 24px;
                                border: none;
                                background: ${buttonColor};
                                color: white;
                                border-radius: 8px;
                                font-weight: 600;
                                cursor: pointer;
                                transition: all 0.2s;
                            ">${confirmText}</button>
                        </div>
                    </div>
                `;

                // Add animations
                const style = document.createElement('style');
                style.textContent = `
                    @keyframes fadeIn {
                        from { opacity: 0; }
                        to { opacity: 1; }
                    }
                    @keyframes fadeOut {
                        from { opacity: 1; }
                        to { opacity: 0; }
                    }
                    @keyframes scaleIn {
                        from { transform: scale(0.9); opacity: 0; }
                        to { transform: scale(1); opacity: 1; }
                    }
                    .confirm-cancel:hover { background: #f3f4f6 !important; }
                    .confirm-ok:hover { opacity: 0.9; }
                `;
                if (!document.getElementById('confirm-styles')) {
                    style.id = 'confirm-styles';
                    document.head.appendChild(style);
                }

                document.body.appendChild(overlay);

                const closeDialog = (result) => {
                    overlay.style.animation = 'fadeOut 0.2s ease-in forwards';
                    setTimeout(() => {
                        document.body.removeChild(overlay);
                        resolve(result);
                    }, 200);
                };

                overlay.querySelector('.confirm-ok').addEventListener('click', () => closeDialog(true));
                overlay.querySelector('.confirm-cancel').addEventListener('click', () => closeDialog(false));
                overlay.addEventListener('click', (e) => {
                    if (e.target === overlay) closeDialog(false);
                });

                // Focus confirm button
                overlay.querySelector('.confirm-ok').focus();
            });
        },

        // Shorthand methods
        danger(message, title = 'Hapus?') {
            return this.show({ title, message, type: 'danger', confirmText: 'Hapus', icon: 'fa-trash-alt' });
        },

        warning(message, title = 'Peringatan') {
            return this.show({ title, message, type: 'warning' });
        }
    };

    // ==================== Form Validation ====================
    const FormValidator = {
        rules: {
            required: {
                validate: (value) => value !== null && value !== undefined && value.toString().trim() !== '',
                message: 'Field ini wajib diisi'
            },
            email: {
                validate: (value) => !value || /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value),
                message: 'Format email tidak valid'
            },
            minLength: {
                validate: (value, param) => !value || value.length >= param,
                message: (param) => `Minimal ${param} karakter`
            },
            maxLength: {
                validate: (value, param) => !value || value.length <= param,
                message: (param) => `Maksimal ${param} karakter`
            },
            min: {
                validate: (value, param) => !value || Number(value) >= param,
                message: (param) => `Nilai minimal ${param}`
            },
            max: {
                validate: (value, param) => !value || Number(value) <= param,
                message: (param) => `Nilai maksimal ${param}`
            },
            pattern: {
                validate: (value, param) => !value || new RegExp(param).test(value),
                message: 'Format tidak valid'
            },
            phone: {
                validate: (value) => !value || /^(\+62|62|0)[0-9]{9,13}$/.test(value.replace(/\s|-/g, '')),
                message: 'Nomor telepon tidak valid'
            },
            password: {
                validate: (value) => !value || /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$/.test(value),
                message: 'Password harus minimal 8 karakter, mengandung huruf besar, huruf kecil, dan angka'
            },
            match: {
                validate: (value, param, form) => {
                    const otherField = form.querySelector(`[name="${param}"]`);
                    return otherField && value === otherField.value;
                },
                message: 'Field tidak cocok'
            },
            url: {
                validate: (value) => {
                    if (!value) return true;
                    try {
                        new URL(value);
                        return true;
                    } catch {
                        return false;
                    }
                },
                message: 'URL tidak valid'
            },
            numeric: {
                validate: (value) => !value || /^[0-9]+$/.test(value),
                message: 'Hanya boleh berisi angka'
            },
            alpha: {
                validate: (value) => !value || /^[a-zA-Z]+$/.test(value),
                message: 'Hanya boleh berisi huruf'
            },
            alphanumeric: {
                validate: (value) => !value || /^[a-zA-Z0-9]+$/.test(value),
                message: 'Hanya boleh berisi huruf dan angka'
            }
        },

        /**
         * Validate a single field
         * @param {HTMLElement} field - Form field
         * @param {HTMLFormElement} form - Parent form
         * @returns {Object} Validation result
         */
        validateField(field, form) {
            const value = field.value;
            const validations = field.dataset.validate ? field.dataset.validate.split('|') : [];
            const errors = [];

            // Check required
            if (field.required && !this.rules.required.validate(value)) {
                errors.push(field.dataset.requiredMsg || this.rules.required.message);
            }

            // Check other validations
            validations.forEach(validation => {
                const [ruleName, param] = validation.split(':');
                const rule = this.rules[ruleName];

                if (rule && !rule.validate(value, param, form)) {
                    const message = typeof rule.message === 'function' 
                        ? rule.message(param) 
                        : (field.dataset[`${ruleName}Msg`] || rule.message);
                    errors.push(message);
                }
            });

            return {
                valid: errors.length === 0,
                errors
            };
        },

        /**
         * Validate entire form
         * @param {HTMLFormElement} form - Form element
         * @returns {Object} Validation result
         */
        validateForm(form) {
            const fields = form.querySelectorAll('input, select, textarea');
            const errors = {};
            let isValid = true;

            fields.forEach(field => {
                if (!field.name) return;
                
                const result = this.validateField(field, form);
                if (!result.valid) {
                    isValid = false;
                    errors[field.name] = result.errors;
                }
            });

            return { valid: isValid, errors };
        },

        /**
         * Show field error
         * @param {HTMLElement} field - Form field
         * @param {string} message - Error message
         */
        showError(field, message) {
            this.clearError(field);

            field.classList.add('is-invalid');
            
            const feedback = document.createElement('div');
            feedback.className = 'invalid-feedback';
            feedback.textContent = message;
            
            const parent = field.parentElement;
            if (parent.classList.contains('input-group')) {
                parent.parentElement.appendChild(feedback);
            } else {
                parent.appendChild(feedback);
            }
        },

        /**
         * Clear field error
         * @param {HTMLElement} field - Form field
         */
        clearError(field) {
            field.classList.remove('is-invalid');
            
            const parent = field.parentElement;
            const container = parent.classList.contains('input-group') ? parent.parentElement : parent;
            const feedback = container.querySelector('.invalid-feedback');
            if (feedback) {
                feedback.remove();
            }
        },

        /**
         * Initialize form validation
         * @param {HTMLFormElement|string} form - Form element or selector
         * @param {Object} options - Options
         */
        init(form, options = {}) {
            const formEl = typeof form === 'string' ? document.querySelector(form) : form;
            if (!formEl) return;

            const {
                onSubmit = null,
                validateOnBlur = true,
                validateOnInput = false
            } = options;

            // Real-time validation
            const fields = formEl.querySelectorAll('input, select, textarea');
            fields.forEach(field => {
                if (validateOnBlur) {
                    field.addEventListener('blur', () => {
                        const result = this.validateField(field, formEl);
                        if (!result.valid) {
                            this.showError(field, result.errors[0]);
                        } else {
                            this.clearError(field);
                        }
                    });
                }

                if (validateOnInput) {
                    field.addEventListener('input', debounce(() => {
                        const result = this.validateField(field, formEl);
                        if (result.valid) {
                            this.clearError(field);
                        }
                    }, 300));
                }

                // Clear error on input
                field.addEventListener('input', () => {
                    if (field.classList.contains('is-invalid')) {
                        const result = this.validateField(field, formEl);
                        if (result.valid) {
                            this.clearError(field);
                        }
                    }
                });
            });

            // Form submission
            formEl.addEventListener('submit', async (e) => {
                const result = this.validateForm(formEl);

                if (!result.valid) {
                    e.preventDefault();
                    
                    // Show all errors
                    Object.keys(result.errors).forEach(fieldName => {
                        const field = formEl.querySelector(`[name="${fieldName}"]`);
                        if (field) {
                            this.showError(field, result.errors[fieldName][0]);
                        }
                    });

                    // Focus first invalid field
                    const firstInvalid = formEl.querySelector('.is-invalid');
                    if (firstInvalid) {
                        firstInvalid.focus();
                    }

                    Toast.error('Mohon periksa kembali form Anda');
                    return;
                }

                if (onSubmit) {
                    e.preventDefault();
                    await onSubmit(formEl, e);
                }
            });

            return formEl;
        }
    };

    // ==================== AJAX Helper ====================
    const Ajax = {
        /**
         * Default headers
         */
        defaultHeaders: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
        },

        /**
         * Make AJAX request
         * @param {string} url - Request URL
         * @param {Object} options - Request options
         * @returns {Promise}
         */
        async request(url, options = {}) {
            const {
                method = 'GET',
                data = null,
                headers = {},
                timeout = CONFIG.apiTimeout,
                showLoading = false,
                loadingText = 'Loading...'
            } = options;

            let loadingEl = null;
            if (showLoading) {
                loadingEl = this.showLoading(loadingText);
            }

            const controller = new AbortController();
            const timeoutId = setTimeout(() => controller.abort(), timeout);

            try {
                const fetchOptions = {
                    method,
                    headers: { ...this.defaultHeaders, ...headers },
                    signal: controller.signal
                };

                if (data && method !== 'GET') {
                    if (data instanceof FormData) {
                        delete fetchOptions.headers['Content-Type'];
                        fetchOptions.body = data;
                    } else {
                        fetchOptions.body = JSON.stringify(data);
                    }
                }

                const response = await fetch(url, fetchOptions);
                clearTimeout(timeoutId);

                // Parse response
                const contentType = response.headers.get('content-type');
                let responseData;
                
                if (contentType && contentType.includes('application/json')) {
                    responseData = await response.json();
                } else {
                    responseData = await response.text();
                }

                if (!response.ok) {
                    throw {
                        status: response.status,
                        message: responseData.message || `HTTP Error ${response.status}`,
                        data: responseData
                    };
                }

                return responseData;

            } catch (error) {
                if (error.name === 'AbortError') {
                    throw { message: 'Request timeout', status: 408 };
                }
                throw error;
            } finally {
                if (loadingEl) {
                    this.hideLoading(loadingEl);
                }
            }
        },

        // Shorthand methods
        get(url, options = {}) {
            return this.request(url, { ...options, method: 'GET' });
        },

        post(url, data, options = {}) {
            return this.request(url, { ...options, method: 'POST', data });
        },

        put(url, data, options = {}) {
            return this.request(url, { ...options, method: 'PUT', data });
        },

        delete(url, options = {}) {
            return this.request(url, { ...options, method: 'DELETE' });
        },

        /**
         * Show loading overlay
         * @param {string} text - Loading text
         * @returns {HTMLElement}
         */
        showLoading(text = 'Loading...') {
            const overlay = document.createElement('div');
            overlay.className = 'ajax-loading-overlay';
            overlay.innerHTML = `
                <div class="ajax-loading-content">
                    <div class="ajax-loading-spinner"></div>
                    <p>${text}</p>
                </div>
            `;
            overlay.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(255, 255, 255, 0.9);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 9999;
            `;

            const style = document.createElement('style');
            style.textContent = `
                .ajax-loading-content {
                    text-align: center;
                }
                .ajax-loading-spinner {
                    width: 50px;
                    height: 50px;
                    border: 4px solid #e5e7eb;
                    border-top-color: #8B1538;
                    border-radius: 50%;
                    animation: spin 0.8s linear infinite;
                    margin: 0 auto 15px;
                }
                @keyframes spin {
                    to { transform: rotate(360deg); }
                }
                .ajax-loading-content p {
                    color: #374151;
                    font-weight: 500;
                    margin: 0;
                }
            `;
            if (!document.getElementById('ajax-loading-styles')) {
                style.id = 'ajax-loading-styles';
                document.head.appendChild(style);
            }

            document.body.appendChild(overlay);
            return overlay;
        },

        /**
         * Hide loading overlay
         * @param {HTMLElement} overlay - Loading overlay element
         */
        hideLoading(overlay) {
            if (overlay && overlay.parentElement) {
                overlay.parentElement.removeChild(overlay);
            }
        }
    };

    // ==================== Progress Bar ====================
    const ProgressBar = {
        /**
         * Animate progress bar
         * @param {HTMLElement|string} element - Progress bar element or selector
         * @param {number} targetValue - Target percentage (0-100)
         * @param {Object} options - Animation options
         */
        animate(element, targetValue, options = {}) {
            const el = typeof element === 'string' ? document.querySelector(element) : element;
            if (!el) return;

            const {
                duration = 1000,
                easing = 'easeOutQuart',
                onUpdate = null,
                onComplete = null
            } = options;

            const startValue = parseFloat(el.style.width) || 0;
            const startTime = performance.now();

            const easingFunctions = {
                linear: t => t,
                easeOutQuart: t => 1 - Math.pow(1 - t, 4),
                easeInOutQuart: t => t < 0.5 ? 8 * t * t * t * t : 1 - Math.pow(-2 * t + 2, 4) / 2
            };

            const easeFn = easingFunctions[easing] || easingFunctions.linear;

            const updateProgress = (currentTime) => {
                const elapsed = currentTime - startTime;
                const progress = Math.min(elapsed / duration, 1);
                const easedProgress = easeFn(progress);
                const currentValue = startValue + (targetValue - startValue) * easedProgress;

                el.style.width = `${currentValue}%`;
                
                if (el.hasAttribute('aria-valuenow')) {
                    el.setAttribute('aria-valuenow', Math.round(currentValue));
                }

                // Update text if present
                const textEl = el.querySelector('.progress-text') || el;
                if (textEl.dataset.showPercent) {
                    textEl.textContent = `${Math.round(currentValue)}%`;
                }

                if (onUpdate) {
                    onUpdate(currentValue);
                }

                if (progress < 1) {
                    requestAnimationFrame(updateProgress);
                } else if (onComplete) {
                    onComplete();
                }
            };

            requestAnimationFrame(updateProgress);
        },

        /**
         * Initialize progress bars with data attributes
         */
        initAll() {
            document.querySelectorAll('[data-progress-animate]').forEach(el => {
                const target = parseFloat(el.dataset.progressAnimate);
                const duration = parseInt(el.dataset.progressDuration) || 1000;
                
                // Only animate when in viewport
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            this.animate(el, target, { duration });
                            observer.disconnect();
                        }
                    });
                });
                
                observer.observe(el);
            });
        }
    };

    // ==================== Utility Functions ====================

    /**
     * Debounce function
     * @param {Function} func - Function to debounce
     * @param {number} wait - Wait time in milliseconds
     * @returns {Function}
     */
    function debounce(func, wait = CONFIG.debounceDelay) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func.apply(this, args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }

    /**
     * Throttle function
     * @param {Function} func - Function to throttle
     * @param {number} limit - Limit in milliseconds
     * @returns {Function}
     */
    function throttle(func, limit) {
        let inThrottle;
        return function(...args) {
            if (!inThrottle) {
                func.apply(this, args);
                inThrottle = true;
                setTimeout(() => inThrottle = false, limit);
            }
        };
    }

    /**
     * Format currency (Indonesian Rupiah)
     * @param {number} amount - Amount to format
     * @returns {string}
     */
    function formatCurrency(amount) {
        return new Intl.NumberFormat('id-ID', {
            style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0,
            maximumFractionDigits: 0
        }).format(amount);
    }

    /**
     * Format number with thousand separators
     * @param {number} number - Number to format
     * @returns {string}
     */
    function formatNumber(number) {
        return new Intl.NumberFormat('id-ID').format(number);
    }

    /**
     * Format date
     * @param {Date|string} date - Date to format
     * @param {string} format - Format type: 'short', 'long', 'datetime'
     * @returns {string}
     */
    function formatDate(date, format = 'short') {
        const d = new Date(date);
        const options = {
            short: { day: 'numeric', month: 'short', year: 'numeric' },
            long: { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' },
            datetime: { day: 'numeric', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' }
        };
        return d.toLocaleDateString('id-ID', options[format] || options.short);
    }

    /**
     * Parse query string
     * @param {string} query - Query string
     * @returns {Object}
     */
    function parseQueryString(query = window.location.search) {
        return Object.fromEntries(new URLSearchParams(query));
    }

    /**
     * Build query string
     * @param {Object} params - Parameters
     * @returns {string}
     */
    function buildQueryString(params) {
        return new URLSearchParams(params).toString();
    }

    /**
     * Copy text to clipboard
     * @param {string} text - Text to copy
     * @returns {Promise<boolean>}
     */
    async function copyToClipboard(text) {
        try {
            await navigator.clipboard.writeText(text);
            Toast.success('Berhasil disalin!');
            return true;
        } catch (err) {
            // Fallback for older browsers
            const textarea = document.createElement('textarea');
            textarea.value = text;
            textarea.style.position = 'fixed';
            textarea.style.opacity = '0';
            document.body.appendChild(textarea);
            textarea.select();
            
            try {
                document.execCommand('copy');
                Toast.success('Berhasil disalin!');
                return true;
            } catch (e) {
                Toast.error('Gagal menyalin');
                return false;
            } finally {
                document.body.removeChild(textarea);
            }
        }
    }

    /**
     * Smooth scroll to element
     * @param {HTMLElement|string} target - Target element or selector
     * @param {number} offset - Offset from top
     */
    function scrollTo(target, offset = 0) {
        const el = typeof target === 'string' ? document.querySelector(target) : target;
        if (!el) return;

        const top = el.getBoundingClientRect().top + window.pageYOffset - offset;
        window.scrollTo({ top, behavior: 'smooth' });
    }

    /**
     * Check if element is in viewport
     * @param {HTMLElement} el - Element to check
     * @returns {boolean}
     */
    function isInViewport(el) {
        const rect = el.getBoundingClientRect();
        return (
            rect.top >= 0 &&
            rect.left >= 0 &&
            rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
            rect.right <= (window.innerWidth || document.documentElement.clientWidth)
        );
    }

    /**
     * Generate unique ID
     * @returns {string}
     */
    function generateId() {
        return 'id_' + Math.random().toString(36).substr(2, 9);
    }

    // ==================== Auto-initialize ====================
    document.addEventListener('DOMContentLoaded', () => {
        // Initialize progress bar animations
        ProgressBar.initAll();

        // Auto-init forms with data-validate attribute
        document.querySelectorAll('form[data-validate]').forEach(form => {
            FormValidator.init(form);
        });

        // Initialize tooltips if Bootstrap is available
        if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
            document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => {
                new bootstrap.Tooltip(el);
            });
        }

        // Back to top button
        const backToTop = document.querySelector('.back-to-top');
        if (backToTop) {
            window.addEventListener('scroll', throttle(() => {
                if (window.pageYOffset > 300) {
                    backToTop.classList.add('show');
                } else {
                    backToTop.classList.remove('show');
                }
            }, 100));

            backToTop.addEventListener('click', (e) => {
                e.preventDefault();
                window.scrollTo({ top: 0, behavior: 'smooth' });
            });
        }
    });

    // ==================== Export to Global Scope ====================
    window.NusaTech = {
        Toast,
        Confirm,
        FormValidator,
        Ajax,
        ProgressBar,
        Utils: {
            debounce,
            throttle,
            formatCurrency,
            formatNumber,
            formatDate,
            parseQueryString,
            buildQueryString,
            copyToClipboard,
            scrollTo,
            isInViewport,
            generateId
        }
    };

})();

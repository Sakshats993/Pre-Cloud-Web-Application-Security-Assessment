"""
Pre-Cloud Security Remediation Helper Scripts

Purpose:
Automated helper functions to mitigate common application-level vulnerabilities
identified during the Pre-Cloud Web Application Security Assessment.
"""

import re
import hashlib
import secrets
from typing import Dict


class SecurityRemediator:
    """
    Helper class providing reusable security remediation utilities.
    """

    @staticmethod
    def sanitize_sql_input(user_input: str) -> str:
        """
        Sanitize user input to reduce SQL injection risk.
        NOTE: This is a defense-in-depth measure and should NOT
        replace parameterized queries.
        """
        dangerous_patterns = [
            "'", '"', ";", "--", "/*", "*/",
            "xp_", "sp_", "union", "select", "drop"
        ]

        sanitized = user_input.lower()
        for pattern in dangerous_patterns:
            sanitized = sanitized.replace(pattern, "")

        sanitized = re.sub(r'[^a-zA-Z0-9\s\-_\.@]', '', sanitized)
        return sanitized[:100]

    @staticmethod
    def generate_secure_token(length: int = 32) -> str:
        """
        Generate a cryptographically secure random token.
        """
        return secrets.token_hex(length)

    @staticmethod
    def hash_password(password: str, salt: bytes = None) -> Dict[str, str]:
        """
        Securely hash a password using PBKDF2-HMAC-SHA256.
        """
        if salt is None:
            salt = secrets.token_bytes(32)

        key = hashlib.pbkdf2_hmac(
            'sha256',
            password.encode('utf-8'),
            salt,
            100000
        )

        return {
            "hash": key.hex(),
            "salt": salt.hex()
        }

    @staticmethod
    def validate_file_upload(filename: str, content: bytes) -> Dict[str, bool]:
        """
        Validate uploaded files to prevent malicious uploads.
        """
        allowed_extensions = ['jpg', 'jpeg', 'png', 'gif', 'pdf', 'txt']
        max_size = 5 * 1024 * 1024  # 5 MB

        extension = filename.split('.')[-1].lower() if '.' in filename else ''
        size_ok = len(content) <= max_size

        magic_numbers = {
            b'\xFF\xD8\xFF': 'jpeg',
            b'\x89\x50\x4E\x47': 'png',
            b'\x47\x49\x46': 'gif',
            b'\x25\x50\x44\x46': 'pdf'
        }

        detected_type = None
        for magic, ftype in magic_numbers.items():
            if content.startswith(magic):
                detected_type = ftype
                break

        return {
            "extension_allowed": extension in allowed_extensions,
            "size_ok": size_ok,
            "type_matches": detected_type == extension if detected_type else True,
            "safe": extension in allowed_extensions and size_ok
        }

    @staticmethod
    def security_headers() -> Dict[str, str]:
        """
        Return recommended HTTP security headers.
        """
        return {
            "Strict-Transport-Security": "max-age=31536000; includeSubDomains",
            "X-Content-Type-Options": "nosniff",
            "X-Frame-Options": "DENY",
            "X-XSS-Protection": "1; mode=block",
            "Content-Security-Policy": "default-src 'self'",
            "Referrer-Policy": "strict-origin-when-cross-origin",
            "Permissions-Policy": "geolocation=(), microphone=(), camera=()"
        }


if __name__ == "__main__":
    remediator = SecurityRemediator()

    # Example usage
    malicious_input = "'; DROP TABLE users;--"
    print("Sanitized input:", remediator.sanitize_sql_input(malicious_input))

    token = remediator.generate_secure_token()
    print("Generated token:", token)

    password_data = remediator.hash_password("StrongPassword123!")
    print("Password hash:", password_data["hash"][:20], "...")

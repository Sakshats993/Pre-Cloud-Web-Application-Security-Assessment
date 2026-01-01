````markdown
# Nikto Scan Results

## Purpose
This document contains the results of a **Nikto web server vulnerability scan** conducted as part of the Pre-Cloud Web Application Security Assessment.

Nikto was used to identify:
- Server misconfigurations
- Outdated components
- Missing security headers
- Potentially dangerous files and settings

---

## Scan Details

- **Tool:** Nikto
- **Version:** 2.1.6
- **Target:** http://localhost:3000
- **Scan Type:** Web server configuration assessment
- **Scan Duration:** ~25 minutes

---

## Summary of Findings

| Category | Findings |
|--------|----------|
| Critical | 0 |
| High | 4 |
| Medium | 6 |
| Low | 5 |
| **Total** | **15** |

---

## Detailed Findings

### 1. Missing Security Headers

**Description:**  
Several recommended HTTP security headers are missing from server responses.

**Headers Missing:**
- X-Frame-Options
- X-Content-Type-Options
- Content-Security-Policy
- Referrer-Policy
- Permissions-Policy

**Impact:**  
Increased exposure to clickjacking and browser-based attacks.

**Recommendation:**  
Configure security headers at application or reverse proxy level.

---

### 2. Server Banner Disclosure

**Description:**  
The web server discloses software name and version.

**Observed Header:**
```http
Server: Express/4.16.0
````

**Impact:**
Allows attackers to target known vulnerabilities.

**Recommendation:**
Disable or obfuscate server banners.

---

### 3. Outdated Framework Version

**Description:**
An outdated version of Express.js was detected.

**Detected Version:**

* Express 4.16.0

**Impact:**
Known vulnerabilities may exist in outdated frameworks.

**Recommendation:**
Upgrade to the latest stable version and apply patches.

---

### 4. Cookie Without Secure Flag

**Description:**
Session cookies were observed without the `Secure` attribute.

**Impact:**
Cookies may be transmitted over unencrypted connections.

**Recommendation:**
Set `Secure` and `HttpOnly` flags on all session cookies.

---

### 5. Cookie Without HttpOnly Flag

**Description:**
Cookies are accessible via client-side scripts.

**Impact:**
Increases risk of session theft via XSS.

**Recommendation:**
Add the `HttpOnly` flag to cookies.

---

### 6. HTTP Methods Enabled

**Description:**
Unnecessary HTTP methods are enabled on the server.

**Methods Detected:**

* GET
* POST
* OPTIONS
* PUT

**Impact:**
Expanded attack surface.

**Recommendation:**
Restrict HTTP methods to only those required.

---

### 7. X-Powered-By Header Present

**Description:**
The `X-Powered-By` header discloses backend technology.

**Impact:**
Assists attacker reconnaissance.

**Recommendation:**
Disable the `X-Powered-By` header.

---

### 8. Missing Cache-Control Headers

**Description:**
Responses do not specify cache-control directives.

**Impact:**
Sensitive data may be cached by browsers.

**Recommendation:**
Add `Cache-Control: no-store, no-cache`.

---

### 9. No Rate Limiting Detected

**Description:**
Nikto detected no evidence of request throttling.

**Impact:**
Enables brute-force and automated attacks.

**Recommendation:**
Implement rate limiting at application or WAF level.

---

### 10. Insecure Default Configuration

**Description:**
Default application settings appear to be in use.

**Impact:**
May expose unnecessary functionality.

**Recommendation:**
Harden configurations for production deployment.

---

## Nikto Scan Limitations

* Nikto does not validate exploitability
* False positives are possible
* Manual validation is required for confirmation

Findings were manually reviewed and correlated with other tools such as OWASP ZAP and Burp Suite.

---

## Conclusion

Nikto identified multiple **configuration-related weaknesses** that contribute to the overall security risk.

These findings reinforce the need for:

* Configuration hardening
* Secure defaults
* Proper server header management

Nikto results should be used in conjunction with other scanning and manual testing techniques for accurate risk assessment.

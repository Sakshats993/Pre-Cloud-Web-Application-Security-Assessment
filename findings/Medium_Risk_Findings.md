# Medium Risk Vulnerability Findings

## MED-001: Missing Anti-CSRF Tokens

### Description
The application does not implement Cross-Site Request Forgery (CSRF) protection on state-changing requests, allowing attackers to perform unauthorized actions on behalf of authenticated users.

### Location
- **Affected Methods:** POST, PUT
- **Affected Endpoints:**
  - `/api/feedback`
  - `/rest/user/profile`
  - `/rest/basket/add`

### Impact
- Unauthorized account actions
- Forced transactions
- Data manipulation

### Remediation
- Implement CSRF tokens for all state-changing requests
- Use SameSite cookies (`SameSite=Strict`)
- Validate origin and referer headers

### CVSS Score: 5.4 (Medium)

---

## MED-002: Missing Security Headers

### Description
Several HTTP security headers are not configured, exposing users to browser-based attacks.

### Missing Headers
- X-Frame-Options
- X-Content-Type-Options
- Content-Security-Policy
- Strict-Transport-Security

### Impact
- Clickjacking attacks
- MIME sniffing
- Reduced browser security protections

### Remediation
- Configure security headers at application or CDN level
- Enforce HTTPS using HSTS
- Implement CSP policy

### CVSS Score: 5.0 (Medium)

---

## MED-003: Cookie Without Secure and HttpOnly Flags

### Description
Session cookies are missing `Secure` and `HttpOnly` attributes.

### Location
- **Cookie Names:** `session_id`, `token`

### Impact
- Session hijacking
- Increased XSS impact
- Credential theft

### Remediation
- Set `Secure` flag to ensure cookies are sent only over HTTPS
- Set `HttpOnly` to prevent JavaScript access

### CVSS Score: 5.6 (Medium)

---

## MED-004: Information Disclosure via Error Messages

### Description
Verbose error messages reveal internal application details.

### Location
- Stack traces exposed on invalid input
- Debug messages visible to unauthenticated users

### Impact
- Technology stack disclosure
- Easier exploitation for attackers
- Reconnaissance advantage

### Remediation
- Disable debug mode in production
- Return generic error messages
- Log detailed errors server-side only

### CVSS Score: 4.9 (Medium)

---

## MED-005: Insecure Password Policy

### Description
Password complexity requirements are weak, allowing easily guessable passwords.

### Observed Policy
- Minimum length: 6 characters
- No complexity enforcement

### Impact
- Increased risk of account compromise
- Successful brute-force attacks

### Remediation
- Enforce minimum 10–12 characters
- Require uppercase, lowercase, number, special character
- Implement account lockout policy

### CVSS Score: 5.2 (Medium)

---

## MED-006: Lack of Account Lockout Mechanism

### Description
The application does not lock accounts after multiple failed login attempts.

### Impact
- Brute-force attacks
- Credential stuffing attacks

### Remediation
- Lock account after 5–10 failed attempts
- Implement CAPTCHA after multiple failures
- Alert users on suspicious login attempts

### CVSS Score: 5.8 (Medium)

---

## MED-007: Insecure File Storage Permissions

### Description
Uploaded files inherit overly permissive file permissions.

### Location
- Upload directory permissions set to `777`

### Impact
- Unauthorized file modification
- Potential escalation to code execution

### Remediation
- Restrict file permissions (e.g., `640`)
- Store uploads outside web root
- Use isolated storage buckets

### CVSS Score: 5.3 (Medium)

---

## MED-008: Weak Session Expiration

### Description
Sessions remain valid for extended periods without reauthentication.

### Observed Behavior
- Session timeout exceeds 24 hours
- No idle timeout enforced

### Impact
- Increased session hijacking window
- Persistent unauthorized access

### Remediation
- Implement idle timeout (15–30 minutes)
- Force reauthentication for sensitive actions
- Rotate session IDs regularly

### CVSS Score: 5.1 (Medium)

---

## MED-009: Insufficient Logging of Security Events

### Description
Security-relevant events are not logged consistently.

### Missing Logs
- Failed login attempts
- Privilege changes
- File upload events

### Impact
- Delayed incident detection
- Poor forensic visibility

### Remediation
- Log authentication failures
- Centralize logs (CloudWatch / Azure Monitor)
- Configure alerts for anomalies

### CVSS Score: 4.7 (Medium)

---

## MED-010: CORS Misconfiguration

### Description
CORS policy allows requests from untrusted origins.

### Observed Configuration
- `Access-Control-Allow-Origin: *`
- Credentials allowed

### Impact
- Cross-origin data theft
- Token leakage

### Remediation
- Restrict allowed origins
- Disable credentials for wildcard origins
- Validate CORS policy per endpoint

### CVSS Score: 5.5 (Medium)

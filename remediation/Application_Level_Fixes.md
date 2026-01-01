````markdown
# Application-Level Security Fixes

## Purpose
This document outlines **code-level remediation measures** required to fix vulnerabilities identified during the Pre-Cloud Web Application Security Assessment.

These fixes must be implemented **before cloud deployment**, in addition to cloud-native security controls.

---

## 1. SQL Injection Remediation

### Vulnerability Reference
- CRIT-001: SQL Injection in Search Functionality

### Root Cause
User input is directly concatenated into SQL queries.

### Insecure Code Example
```javascript
db.query(`SELECT * FROM products WHERE name LIKE '%${searchTerm}%'`)
````

### Secure Code Fix

```javascript
db.query(
  'SELECT * FROM products WHERE name LIKE ?',
  [`%${searchTerm}%`]
)
```

### Additional Controls

* Input length validation
* Whitelist acceptable characters
* Use ORM query builders

---

## 2. Authentication & JWT Security Fixes

### Vulnerability Reference

* CRIT-002: Authentication Bypass via JWT Manipulation

### Root Cause

JWT algorithm is not strictly validated.

### Secure Implementation

```javascript
jwt.verify(token, publicKey, {
  algorithms: ['RS256']
})
```

### Additional Controls

* Reject tokens with `alg: none`
* Short token expiry
* Implement refresh tokens
* Rotate signing keys periodically

---

## 3. File Upload Security Fixes

### Vulnerability Reference

* CRIT-003: Remote Code Execution via File Upload

### Root Cause

No file type, size, or content validation.

### Secure File Validation Example

```javascript
const allowedTypes = ['image/jpeg', 'image/png', 'application/pdf'];

if (!allowedTypes.includes(file.mimetype)) {
  throw new Error('Invalid file type');
}
```

### Best Practices

* Validate file extensions AND magic numbers
* Enforce max file size
* Store uploads outside web root
* Process files asynchronously (Lambda / background jobs)

---

## 4. Command Injection Prevention

### Vulnerability Reference

* CRIT-004: Command Injection in Admin Panel

### Root Cause

User input is passed directly to OS commands.

### Secure Design Fix

* Remove system command execution
* Replace with predefined backend functions
* Use allowlists for permitted actions

### Example (Safer Pattern)

```javascript
const allowedActions = {
  restart: restartService,
  status: checkStatus
};

allowedActions[userAction]?.();
```

---

## 5. Secret Management Fixes

### Vulnerability Reference

* CRIT-005: Exposed Database Credentials

### Root Cause

Secrets embedded in client-side code.

### Secure Approach

* Use environment variables
* Fetch secrets from Secrets Manager / Key Vault
* Restrict secret access via IAM / RBAC

### Example

```javascript
const dbPassword = process.env.DB_PASSWORD;
```

---

## 6. Cross-Site Scripting (XSS) Mitigation

### Vulnerability Reference

* HIGH-001: Stored XSS

### Secure Practices

* Encode output before rendering
* Sanitize all user input
* Implement Content Security Policy (CSP)

### Example (Output Encoding)

```javascript
res.send(escapeHtml(userInput));
```

---

## 7. Access Control Enforcement

### Vulnerability Reference

* HIGH-002, HIGH-007: IDOR Issues

### Secure Controls

* Validate user ownership server-side
* Enforce RBAC checks
* Never trust client-supplied IDs

### Example

```javascript
if (resource.ownerId !== currentUser.id) {
  return res.status(403).send('Access denied');
}
```

---

## 8. Password Security Improvements

### Vulnerability Reference

* HIGH-012: Weak Cryptographic Hashing

### Secure Password Storage

```javascript
const bcrypt = require('bcrypt');
const hash = await bcrypt.hash(password, 12);
```

### Best Practices

* Use bcrypt / Argon2
* Apply salting and iterations
* Enforce strong password policy

---

## 9. Session Management Fixes

### Vulnerability Reference

* HIGH-005: Session Fixation

### Secure Measures

* Regenerate session ID after login
* Enforce idle and absolute timeouts
* Use Secure & HttpOnly cookies

---

## 10. Error Handling & Logging

### Vulnerability Reference

* MED-004: Information Disclosure

### Secure Practices

* Disable debug mode in production
* Show generic error messages to users
* Log detailed errors server-side only

---

## Summary

Application-level fixes are **mandatory** and must be implemented alongside:

* WAF rules
* API gateway validation
* Cloud-native monitoring

Secure cloud deployment is **not possible** without fixing application vulnerabilities first.

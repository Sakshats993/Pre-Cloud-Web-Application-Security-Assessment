````markdown
# Web Application Firewall (WAF) Rules Template

## Purpose
This document provides **generic, reusable WAF rule templates** that can be adapted for:
- AWS WAF
- Azure WAF
- Any OWASP CRS–based WAF

These rules are aligned with vulnerabilities identified during the **Pre-Cloud Web Application Security Assessment**.

---

## 1. SQL Injection (SQLi) Protection

### Covered Vulnerabilities
- CRIT-001: SQL Injection
- Injection findings from OWASP ZAP & Nikto

### Generic SQLi Rule Logic
```json
{
  "RuleName": "Block_SQL_Injection",
  "MatchConditions": [
    "UNION SELECT",
    "' OR '1'='1",
    "--",
    "/*",
    "xp_",
    "sp_"
  ],
  "Action": "BLOCK",
  "Log": true
}
````

**Security Benefit:**

* Blocks common SQLi payloads
* Prevents database compromise
* Stops automated exploitation tools

---

## 2. Cross-Site Scripting (XSS) Protection

### Covered Vulnerabilities

* HIGH-001: Stored XSS
* Reflected XSS findings

### Generic XSS Rule Logic

```json
{
  "RuleName": "Block_XSS_Attacks",
  "MatchConditions": [
    "<script>",
    "javascript:",
    "onerror=",
    "onload=",
    "alert("
  ],
  "Action": "BLOCK",
  "Log": true
}
```

**Security Benefit:**

* Prevents browser-side code execution
* Protects user sessions and cookies
* Reduces client-side exploitation

---

## 3. Command Injection Protection

### Covered Vulnerabilities

* CRIT-004: Command Injection

### Generic Command Injection Rule

```json
{
  "RuleName": "Block_Command_Injection",
  "MatchConditions": [
    ";",
    "&&",
    "||",
    "|",
    "`",
    "$("
  ],
  "Action": "BLOCK",
  "Log": true
}
```

**Security Benefit:**

* Prevents OS-level command execution
* Stops backend compromise attempts

---

## 4. File Upload Protection

### Covered Vulnerabilities

* CRIT-003: Remote Code Execution via File Upload

### File Upload Filtering Rule

```json
{
  "RuleName": "Restrict_File_Uploads",
  "AllowedExtensions": [
    "jpg",
    "jpeg",
    "png",
    "gif",
    "pdf",
    "txt"
  ],
  "BlockedExtensions": [
    "php",
    "jsp",
    "exe",
    "sh",
    "py",
    "js"
  ],
  "Action": "BLOCK"
}
```

**Security Benefit:**

* Prevents malicious script uploads
* Reduces RCE risk
* Enforces file type hygiene

---

## 5. Rate Limiting / Brute Force Protection

### Covered Vulnerabilities

* Missing rate limiting
* Brute-force login attempts

### Generic Rate Limiting Rule

```json
{
  "RuleName": "Rate_Limit_Login",
  "Endpoint": "/login",
  "RequestsPerMinute": 100,
  "Action": "BLOCK"
}
```

**Security Benefit:**

* Prevents credential stuffing
* Limits automated abuse
* Protects authentication endpoints

---

## 6. HTTP Method Restriction

### Covered Vulnerabilities

* Insecure design
* Attack surface expansion

### HTTP Method Control Rule

```json
{
  "RuleName": "Restrict_HTTP_Methods",
  "AllowedMethods": [
    "GET",
    "POST"
  ],
  "BlockedMethods": [
    "PUT",
    "DELETE",
    "TRACE",
    "OPTIONS"
  ],
  "Action": "BLOCK"
}
```

**Security Benefit:**

* Reduces unnecessary attack vectors
* Prevents misuse of unused HTTP methods

---

## 7. Logging & Alerting Configuration

### Logging Rule

```json
{
  "RuleName": "Enable_WAF_Logging",
  "LogLevel": "FULL",
  "Destination": "SIEM"
}
```

**Security Benefit:**

* Enables forensic analysis
* Supports incident response
* Improves visibility into attacks

---

## 8. Rule Deployment Order (Recommended)

| Priority | Rule Name                    |
| -------- | ---------------------------- |
| 1        | SQL Injection Protection     |
| 2        | XSS Protection               |
| 3        | Command Injection Protection |
| 4        | File Upload Restrictions     |
| 5        | Rate Limiting                |
| 6        | HTTP Method Restriction      |
| 7        | Logging & Monitoring         |

---

## 9. Summary

These WAF rule templates:

* Align with OWASP Top 10 risks
* Complement application-level security
* Act as a **defense-in-depth layer**
* Are mandatory for internet-facing cloud workloads

WAF should **never replace secure coding**, but must always be deployed as a protective control before production release.


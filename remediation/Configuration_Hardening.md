````markdown
# Configuration Hardening Guide

## Purpose
This document defines **secure configuration baselines** required to harden the application and supporting infrastructure before cloud deployment.

Configuration hardening complements application-level fixes and reduces the overall attack surface.

---

## 1. Application Configuration Hardening

### Disable Debug & Test Modes
**Risk Addressed:** Information disclosure

- Disable debug mode in production
- Remove test endpoints and sample data
- Ensure stack traces are not exposed to users

```bash
NODE_ENV=production
DEBUG=false
````

---

### Secure HTTP Headers

**Risk Addressed:** Browser-based attacks

Required headers:

* Content-Security-Policy
* X-Frame-Options
* X-Content-Type-Options
* Referrer-Policy
* Permissions-Policy
* Strict-Transport-Security

Apply headers at:

* Application layer
* CDN / Load Balancer layer

---

## 2. Authentication & Authorization Hardening

### Password Policy

**Risk Addressed:** Account compromise

* Minimum length: 12 characters
* Require uppercase, lowercase, numbers, symbols
* Prevent password reuse (last 5 passwords)

---

### Multi-Factor Authentication (MFA)

**Risk Addressed:** Credential theft

* Enforce MFA for:

  * Admin accounts
  * Privileged roles
* Prefer:

  * TOTP (Authenticator apps)
  * Hardware keys for admins

---

### Session Configuration

**Risk Addressed:** Session hijacking

* Regenerate session IDs after login
* Idle timeout: 15–30 minutes
* Absolute timeout: 8–12 hours
* Secure cookies:

  * `Secure`
  * `HttpOnly`
  * `SameSite=Strict`

---

## 3. Server & Runtime Hardening

### Remove Unnecessary Services

**Risk Addressed:** Expanded attack surface

* Disable unused ports
* Remove unused packages and services
* Limit outbound network access

---

### File System Permissions

**Risk Addressed:** Privilege escalation

* Principle of least privilege
* Restrict upload directories
* Prevent execution permissions on uploads

```bash
chmod 640 uploads/
```

---

### Environment Variables

**Risk Addressed:** Secret leakage

* Store secrets in environment variables
* Never hardcode secrets
* Rotate secrets periodically

---

## 4. Network & Transport Security

### TLS Configuration

**Risk Addressed:** Man-in-the-middle attacks

* Enforce TLS 1.2+
* Disable weak ciphers
* Redirect HTTP to HTTPS

---

### Security Groups / Firewall Rules

**Risk Addressed:** Unauthorized access

* Allow only required ports:

  * 443 (HTTPS)
* Restrict admin access to trusted IP ranges
* Deny all by default

---

## 5. Logging & Monitoring Hardening

### Centralized Logging

**Risk Addressed:** Delayed incident detection

* Centralize logs (CloudWatch / Azure Monitor)
* Log:

  * Authentication failures
  * Privilege changes
  * File uploads
  * Configuration changes

---

### Alerting

**Risk Addressed:** Undetected attacks

* Alert on:

  * Multiple failed logins
  * WAF rule triggers
  * Sudden traffic spikes
  * Permission changes

---

## 6. Dependency & Patch Management

### Dependency Updates

**Risk Addressed:** Known vulnerabilities

* Remove unused dependencies
* Update outdated libraries
* Monitor CVEs regularly

---

### OS & Runtime Patching

**Risk Addressed:** Exploitable system flaws

* Enable automatic security updates
* Patch base images regularly
* Scan container images for vulnerabilities

---

## 7. Backup & Recovery Configuration

### Backup Strategy

**Risk Addressed:** Data loss

* Automated daily backups
* Encrypted backups
* Test restore procedures quarterly

---

## 8. Secure Defaults Checklist

| Area         | Secure Default  |
| ------------ | --------------- |
| Debug Mode   | Disabled        |
| TLS          | Enforced        |
| Secrets      | Externalized    |
| MFA          | Enabled         |
| Logging      | Centralized     |
| File Uploads | Restricted      |
| Permissions  | Least privilege |

---

## Summary

Configuration hardening is a **mandatory security control** and must be implemented before cloud deployment.

Even a secure application can be compromised if deployed with weak configurations.


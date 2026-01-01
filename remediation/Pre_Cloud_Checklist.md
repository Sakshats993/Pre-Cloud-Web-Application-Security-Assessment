# Pre-Cloud Deployment Security Checklist

## Purpose
This checklist ensures that all **critical security requirements** are met before deploying the application to a cloud environment.

All items marked **Critical** must be completed before production release.

---

## 1. Application Security

### Critical Requirements
- [ ] All SQL injection vulnerabilities remediated
- [ ] All authentication bypass issues fixed
- [ ] Input validation implemented on all endpoints
- [ ] Secure file upload controls in place
- [ ] XSS protections implemented
- [ ] CSRF protection enabled
- [ ] Security headers configured

### Validation Evidence
- Code review completed
- Security testing passed
- Findings re-tested and closed

---

## 2. Authentication & Access Control

### Critical Requirements
- [ ] Strong password policy enforced
- [ ] MFA enabled for all admin and privileged users
- [ ] JWT implementation hardened
- [ ] RBAC enforced server-side
- [ ] Session management secured
- [ ] Account lockout configured

---

## 3. Secrets & Data Protection

### Critical Requirements
- [ ] No secrets hardcoded in codebase
- [ ] Secrets stored in Secrets Manager / Key Vault
- [ ] Database credentials rotated
- [ ] Encryption at rest enabled
- [ ] Encryption in transit enforced

---

## 4. Infrastructure & Network Security

### Critical Requirements
- [ ] WAF enabled and tested
- [ ] Rate limiting configured
- [ ] DDoS protection enabled
- [ ] Security groups/firewalls hardened
- [ ] Only required ports exposed
- [ ] Network segmentation implemented

---

## 5. Cloud Configuration & Hardening

### Critical Requirements
- [ ] Debug mode disabled
- [ ] Secure configuration defaults applied
- [ ] Least privilege IAM/RBAC enforced
- [ ] Logging enabled for all critical services
- [ ] Configuration reviewed and approved

---

## 6. Logging, Monitoring & Alerting

### Critical Requirements
- [ ] Centralized logging configured
- [ ] Security monitoring enabled
- [ ] Alerts configured for security events
- [ ] Incident response process documented
- [ ] Monitoring dashboard validated

---

## 7. Vulnerability Management

### Critical Requirements
- [ ] All Critical vulnerabilities resolved
- [ ] All High vulnerabilities resolved
- [ ] Medium risks reviewed and accepted or mitigated
- [ ] Low risks documented

---

## 8. Backup & Recovery

### Critical Requirements
- [ ] Automated backups configured
- [ ] Backups encrypted
- [ ] Restore process tested
- [ ] Disaster recovery plan documented

---

## 9. Compliance & Governance

### Requirements
- [ ] Security policies documented
- [ ] Data retention policies defined
- [ ] Privacy policy updated
- [ ] Regulatory requirements reviewed (GDPR, PCI-DSS if applicable)

---

## 10. Final Sign-Off

| Stakeholder | Requirement | Status | Date |
|-----------|------------|--------|------|
| Security Team | All security controls implemented | ⏳ Pending | - |
| DevOps Team | Infrastructure hardened | ⏳ Pending | - |
| Compliance Team | Regulatory compliance verified | ⏳ Pending | - |
| Business Owner | Risk acceptance approved | ⏳ Pending | - |

---

## Deployment Gate

The application **MUST NOT** be deployed to production unless:
- All Critical and High findings are resolved
- Security checklist items are completed
- Security sign-off is obtained

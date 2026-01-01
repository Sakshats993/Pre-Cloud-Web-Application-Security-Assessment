````markdown
# Azure Cloud Security Control Mapping

## Purpose
This document maps identified application vulnerabilities to relevant **Microsoft Azure security controls**.  
These controls are recommended to secure the application **before cloud deployment**.

---

## 1. Azure Web Application Firewall (WAF)

### SQL Injection Protection
**Mapped Vulnerability:**
- CRIT-001: SQL Injection in Search Functionality

**Azure Control:**
- Azure WAF (OWASP Core Rule Set)

```json
{
  "ruleSetType": "OWASP",
  "ruleSetVersion": "3.2",
  "disabledRules": [],
  "exclusions": []
}
````

**Security Benefit:**

* Automatically blocks SQL injection payloads
* Protects HTTP query parameters and request bodies
* Reduces application-layer attack surface

---

### Cross-Site Scripting (XSS) Protection

**Mapped Vulnerabilities:**

* HIGH-001: Stored XSS
* Reflected XSS from automated scans

**Azure Control:**

* Azure WAF – XSS Rules

```json
{
  "ruleId": "941100",
  "action": "Block",
  "description": "XSS Attack Detected via libinjection"
}
```

---

## 2. Azure API Management (APIM)

### Request Validation & Rate Limiting

**Mapped Vulnerabilities:**

* Missing rate limiting
* Broken access control
* Injection flaws

```xml
<policies>
  <inbound>
    <rate-limit calls="100" renewal-period="60" />
    <validate-content unspecified-content-type-action="prevent">
      <content type="application/json" />
    </validate-content>
  </inbound>
</policies>
```

**Security Benefit:**

* Prevents brute-force attacks
* Blocks malformed API requests
* Enforces schema validation

---

## 3. Azure Front Door – Security Headers

### HTTP Security Headers

**Mapped Vulnerabilities:**

* Missing security headers
* Clickjacking
* MIME sniffing

```yaml
securityHeaders:
  Strict-Transport-Security: "max-age=63072000; includeSubDomains"
  X-Frame-Options: "DENY"
  X-Content-Type-Options: "nosniff"
  Referrer-Policy: "strict-origin-when-cross-origin"
  Content-Security-Policy: "default-src 'self'"
```

---

## 4. Azure Key Vault

### Secure Secrets Management

**Mapped Vulnerability:**

* CRIT-005: Exposed Database Credentials

```python
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient

vault_url = "https://precloudvault.vault.azure.net/"
credential = DefaultAzureCredential()
client = SecretClient(vault_url=vault_url, credential=credential)

secret = client.get_secret("DB-PASSWORD")
print(secret.value)
```

**Security Benefit:**

* Removes secrets from codebase
* RBAC-controlled access
* Supports automatic secret rotation

---

## 5. Azure Blob Storage – Secure File Handling

### Secure Upload Configuration

**Mapped Vulnerabilities:**

* Insecure file upload
* Remote code execution

```json
{
  "allowBlobPublicAccess": false,
  "minimumTlsVersion": "TLS1_2",
  "supportsHttpsTrafficOnly": true
}
```

---

## 6. Azure Defender for Cloud

### Threat Detection & Monitoring

**Mapped Vulnerabilities:**

* Lack of monitoring
* Missing alerting

**Enabled Protections:**

* SQL injection anomaly detection
* Suspicious login alerts
* Malware upload detection
* Privilege escalation alerts

---

## 7. Cost vs Security Value Analysis

| Azure Service      | Estimated Monthly Cost | Security Value |
| ------------------ | ---------------------- | -------------- |
| Azure WAF          | $30                    | Critical       |
| API Management     | $40                    | High           |
| Key Vault          | $15                    | Critical       |
| Defender for Cloud | $45                    | High           |
| Azure Monitor      | $20                    | Medium         |
| **Total**          | **$150**               | **High ROI**   |

---

## 8. Summary

By implementing the above Azure security controls, the application gains:

* Strong protection against injection attacks
* Secure credential management
* API abuse prevention
* Improved visibility and threat detection
* Compliance readiness (ISO, SOC 2, PCI-DSS)

These controls are **mandatory before production deployment** on Azure.

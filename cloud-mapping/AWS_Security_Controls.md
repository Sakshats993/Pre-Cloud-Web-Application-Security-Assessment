markdown
# AWS Cloud Security Control Mapping

## Purpose
This document maps identified web application vulnerabilities to appropriate AWS security controls.  
These controls are recommended as part of **pre-cloud deployment hardening**.

---

## 1. AWS Web Application Firewall (WAF)

### SQL Injection Protection
**Mapped Vulnerability:**  
- CRIT-001: SQL Injection in Search Functionality

**Control:** AWS WAF – Managed SQLi Rule Set

```json
{
  "Name": "SQLiRule",
  "Priority": 1,
  "Statement": {
    "SqliMatchStatement": {
      "FieldToMatch": {
        "AllQueryArguments": {}
      },
      "TextTransformations": [
        {
          "Priority": 0,
          "Type": "URL_DECODE"
        }
      ]
    }
  },
  "Action": {
    "Block": {}
  }
}
````

---

### Cross-Site Scripting (XSS) Protection

**Mapped Vulnerabilities:**

* HIGH-001: Stored XSS
* Reflected XSS findings from ZAP

**Control:** AWS WAF – XSS Match Statement

```json
{
  "Name": "XSSRule",
  "Priority": 2,
  "Statement": {
    "XssMatchStatement": {
      "FieldToMatch": {
        "Body": {}
      },
      "TextTransformations": [
        {
          "Priority": 0,
          "Type": "HTML_ENTITY_DECODE"
        }
      ]
    }
  },
  "Action": {
    "Block": {}
  }
}
```

---

## 2. Amazon API Gateway – Request Validation

### Input Validation Model

**Mapped Vulnerabilities:**

* SQL Injection
* XSS
* Command Injection
* Insecure Input Handling

```json
{
  "type": "object",
  "properties": {
    "username": {
      "type": "string",
      "pattern": "^[a-zA-Z0-9]+$",
      "minLength": 3,
      "maxLength": 20
    },
    "email": {
      "type": "string",
      "format": "email"
    }
  },
  "required": ["username", "email"]
}
```

**Security Benefit:**

* Blocks malformed requests before reaching application
* Reduces attack surface
* Prevents injection attempts at API layer

---

## 3. Amazon CloudFront – Security Headers

### Security Headers Policy

**Mapped Vulnerabilities:**

* Missing Security Headers
* Clickjacking
* MIME-type sniffing
* Weak browser protections

```yaml
SecurityHeadersPolicy:
  Comment: Pre-Cloud Security Headers
  SecurityHeadersConfig:
    StrictTransportSecurity:
      AccessControlMaxAgeSec: 63072000
      IncludeSubdomains: true
      Override: true
    ContentTypeOptions:
      Override: true
    FrameOptions:
      FrameOption: DENY
      Override: true
    ReferrerPolicy:
      ReferrerPolicy: strict-origin-when-cross-origin
      Override: true
    XSSProtection:
      ModeBlock: true
      Protection: true
      Override: true
    ContentSecurityPolicy:
      ContentSecurityPolicy: "default-src 'self'"
      Override: true
```

---

## 4. AWS Secrets Manager

### Secure Credential Management

**Mapped Vulnerability:**

* CRIT-005: Exposed Database Credentials

**Recommended Integration Example:**

```python
import boto3
import json

def get_secret(secret_name):
    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name='us-east-1'
    )

    response = client.get_secret_value(SecretId=secret_name)
    return json.loads(response['SecretString'])
```

**Security Benefit:**

* Removes credentials from source code
* Enables automatic secret rotation
* IAM-controlled access

---

## 5. Amazon S3 – Secure Storage Policy

### Enforce Encrypted Transport

**Mapped Vulnerabilities:**

* Insecure file upload handling
* Data exposure risks

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyInsecureConnections",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::pre-cloud-secure-bucket/*"
      ],
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
```

---

## 6. Cost vs Security Value Analysis

| AWS Service     | Estimated Monthly Cost | Security Value |
| --------------- | ---------------------- | -------------- |
| AWS WAF         | $25                    | Critical       |
| API Gateway     | $35                    | High           |
| Secrets Manager | $40                    | Critical       |
| CloudTrail      | $20                    | Medium         |
| GuardDuty       | $50                    | High           |
| **Total**       | **$170**               | **High ROI**   |

---

## 7. Summary

Implementing the above AWS security controls significantly reduces the risk of:

* Injection attacks
* Credential leakage
* Unauthorized access
* Browser-based exploitation
* Data exfiltration

These controls are **mandatory** before deploying the application into a production AWS environment.

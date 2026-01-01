````markdown
# Nmap Service Discovery Results

## Purpose
This document contains the results of **network and service discovery** performed using Nmap as part of the Pre-Cloud Web Application Security Assessment.

Nmap was used to:
- Identify exposed services and open ports
- Detect service versions
- Identify potential misconfigurations
- Validate network exposure prior to cloud deployment

---

## Scan Configuration

- **Tool:** Nmap
- **Version:** 7.94
- **Scan Type:** TCP SYN Scan + Service Version Detection
- **Command Used:**
```bash
nmap -sS -sV -Pn -T4 localhost
````

* **Target:** localhost
* **Scan Duration:** ~3 minutes

---

## Open Ports & Services

| Port | Protocol | Service | Version           | Risk   |
| ---- | -------- | ------- | ----------------- | ------ |
| 80   | TCP      | HTTP    | Express.js        | Medium |
| 3000 | TCP      | HTTP    | Node.js / Express | High   |
| 443  | TCP      | HTTPS   | Not configured    | Low    |
| 22   | TCP      | SSH     | OpenSSH 8.x       | Medium |

---

## Detailed Findings

---

### 1. HTTP Service on Port 3000

**Description:**
The application is directly exposed on port `3000`, commonly used for development environments.

**Risk:**
High

**Impact:**

* Increased attack surface
* Bypasses reverse proxy / WAF
* Direct access to backend service

**Recommendation:**

* Do not expose development ports
* Place application behind load balancer or API gateway
* Restrict direct access using firewall rules

---

### 2. HTTP Service on Port 80

**Description:**
Unencrypted HTTP service is accessible.

**Risk:**
Medium

**Impact:**

* Susceptible to man-in-the-middle attacks
* Sensitive data may be transmitted in plaintext

**Recommendation:**

* Redirect HTTP to HTTPS
* Enforce TLS for all connections

---

### 3. HTTPS Not Properly Configured

**Description:**
Port 443 is open but not properly configured with a valid TLS certificate.

**Risk:**
Low

**Impact:**

* Incomplete transport security
* User trust issues

**Recommendation:**

* Configure TLS certificates
* Enforce TLS 1.2+
* Use managed certificates (ACM / Azure Certificates)

---

### 4. SSH Service Exposed

**Description:**
SSH service is accessible from the network.

**Port:**
22/tcp

**Risk:**
Medium

**Impact:**

* Potential brute-force attacks
* Unauthorized administrative access

**Recommendation:**

* Restrict SSH access to trusted IPs
* Use key-based authentication only
* Disable password authentication
* Consider VPN or bastion host

---

## Service Version Detection Observations

* Express.js framework detected
* Node.js runtime inferred
* OpenSSH version identified

**Security Concern:**
Service fingerprinting enables attackers to target known vulnerabilities.

---

## Nmap Scan Limitations

* Does not assess application-layer vulnerabilities
* Localhost scan does not represent full cloud exposure
* UDP services not scanned

Nmap results were correlated with:

* OWASP ZAP
* Nikto
* Burp Suite

---

## Conclusion

Nmap identified **unnecessary service exposure** and **development-style configurations** that must be corrected before cloud deployment.

Network hardening steps such as:

* Port restriction
* TLS enforcement
* Access control

are required to reduce attack surface and improve cloud readiness.

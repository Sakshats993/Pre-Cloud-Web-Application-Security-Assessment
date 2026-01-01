![Status](https://img.shields.io/badge/Project-Completed-brightgreen)
# 🛡️ Pre-Cloud Web Application Security Assessment

## 📌 Overview
This project presents a **web vulnerability scanning and security assessment report** focused on identifying risks **before deploying an application to a cloud environment**.  
The objective is to adopt a **shift-left security approach**, ensuring that common web application vulnerabilities and misconfigurations are addressed early to reduce cloud attack surfaces.

The assessment is conducted in a **controlled lab environment** using deliberately vulnerable applications and industry-standard security tools.

---

## 🎯 Project Objectives
- Identify common web application vulnerabilities prior to cloud deployment  
- Analyze risks aligned with **OWASP Top 10**  
- Provide actionable remediation and **pre-cloud hardening recommendations**  
- Map application vulnerabilities to **cloud-native security controls**  

---

## 🧰 Technologies Involved
### Web Technologies
- HTTP / HTTPS  
- HTML  
- JavaScript (client-side behavior analysis)  
- REST-style web requests and responses  

### Server-side Environment (Test Application)
- Deliberately vulnerable web applications such as:
  - **OWASP Juice Shop**
  - **DVWA**
- Backend technologies used by the test applications:
  - **Node.js / PHP**

> No custom application development is performed. The focus is on **security assessment and analysis**.


## 🔍 Tools Used
The following industry-standard tools were used during the assessment:

- **OWASP ZAP** – Primary automated and manual vulnerability scanner  
- **Burp Suite (Community Edition)** – Manual request inspection and validation  
- **Nikto** – Web server and configuration vulnerability scanning  
- **Nmap** – Basic network and service exposure identification  

All tools were used in a **non-intrusive and ethical testing environment**.

---

## 🧪 Methodology
The assessment follows a structured security testing approach:

1. **Reconnaissance & Application Mapping**  
   - Identify application endpoints and functionality  

2. **Automated Scanning**  
   - Detect common vulnerabilities and misconfigurations  

3. **Manual Validation**  
   - Verify findings to reduce false positives  

4. **Risk Classification**  
   - Assess severity and potential impact  

---

## 📊 Key Findings
The vulnerabilities identified are mapped to the **OWASP Top 10**, including but not limited to:

- SQL Injection  
- Cross-Site Scripting (XSS)  
- Broken Authentication  
- Security Misconfiguration  
- Sensitive Data Exposure  
- Missing Security Headers  

Each finding includes:
- Description  
- Severity level  
- Technical impact  

---

## 🛠️ Recommendations
Recommendations are provided at multiple levels:

- **Application-level remediation**
- **Security configuration improvements**
- **Pre-cloud deployment hardening measures**
- Secure handling of authentication and data

---

## Threat Model Summary

### Primary Threat Actors
- External attackers
- Automated bots
- Malicious authenticated users

### Key Attack Vectors
- Injection attacks (SQLi, command injection)
- Authentication bypass
- Insecure file uploads
- Excessive permissions

### High-Value Assets
- User credentials
- Personally Identifiable Information (PII)
- Application source logic
- Backend infrastructure

### Trust Boundaries
- Internet → WAF
- WAF → Application
- Application → Database
- Application → Object Storage

## ☁️ Cloud Security Mapping
Each vulnerability is mapped to **cloud-native mitigation strategies**, such as:

- Web Application Firewall (WAF) rules  
- Secure access control and identity management  
- Network exposure reduction  
- Secure deployment best practices  
This demonstrates how addressing issues early improves **cloud security posture**.

## Architecture Overview

```mermaid
flowchart TB
    User[End User / Attacker]
    Internet[Internet]
    WAF[Web Application Firewall]
    APIGW[API Gateway / Load Balancer]
    App[Web Application<br/>Node.js / Express]
    DB[(Database)]
    Storage[(Object Storage)]
    Logs[Logging & Monitoring]

    User --> Internet
    Internet --> WAF
    WAF --> APIGW
    APIGW --> App
    App --> DB
    App --> Storage
    App --> Logs
    WAF --> Logs
    APIGW --> Logs
``` 
## ⚙️ Setup (Optional – Lab Environment)
This project does not require custom code execution.

Optional setup for testing:
- Deploy OWASP Juice Shop or DVWA locally or in a lab environment
- Run scanning tools with default configurations
- Analyze and document findings

---
## Future Improvements

- Integrate SAST and dependency scanning (Snyk, Semgrep)
- Add container security scanning
- Implement CI/CD security gates
- Expand cloud security mapping for Azure and GCP
- Perform authenticated scanning and role-based testing


## Assumptions & Limitations

- Testing performed in an isolated lab environment
- No denial-of-service testing conducted
- Cloud deployment simulated, not production
- Findings based on time-boxed assessment

---

## Key Takeaways

- Performed a full pre-cloud security assessment combining automated scanning and manual validation
- Identified and triaged vulnerabilities using OWASP Top 10 and CVSS
- Demonstrated defense-in-depth by combining application fixes with cloud-native controls
- Mapped application risks to AWS security services (WAF, IAM, Secrets Manager, Monitoring)
- Highlighted limitations of automated tools through false-positive analysis

## 📄 Disclaimer
This project is created **strictly for educational and portfolio purposes**.

- No real-world or production systems were tested  
- No sensitive or confidential data is included  
- All activities were conducted in a controlled lab environment  

---

## 👤 Author
**Sakshat S**  
Aspiring Cloud Security Engineer  
Focused on pre-cloud security, risk reduction, and secure cloud adoption

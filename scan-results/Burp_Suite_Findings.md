````markdown
# Burp Suite Manual Testing Findings

## Purpose
This document captures vulnerabilities and security weaknesses identified through **manual testing using Burp Suite**.

Burp Suite was used to:
- Intercept and modify HTTP requests
- Validate automated scan findings
- Identify business logic flaws
- Test authentication, authorization, and input handling

---

## Testing Configuration

- **Tool:** Burp Suite (Community Edition)
- **Testing Type:** Manual request interception & replay
- **Target Application:** OWASP Juice Shop
- **Authentication State:** Authenticated and unauthenticated testing
- **Scope:** All application endpoints

---

## Summary of Findings

| Severity | Count |
|--------|-------|
| Critical | 2 |
| High | 6 |
| Medium | 5 |
| Low | 3 |
| **Total** | **16** |

---

## Detailed Findings

---

### 1. SQL Injection Confirmation

**Severity:** Critical  
**Related Finding:** CRIT-001

**Description:**  
Burp Repeater was used to manually inject SQL payloads into the search endpoint, confirming exploitable SQL injection.

**Endpoint:**  
`/rest/products/search?q=`

**Payload Used:**
```sql
' UNION SELECT id, email, password FROM Users--
````

**Result:**
Sensitive database records were returned in the HTTP response.

---

### 2. Authentication Bypass via JWT Manipulation

**Severity:** Critical
**Related Finding:** CRIT-002

**Description:**
JWT token was modified by changing the algorithm to `none`, resulting in successful authentication bypass.

**Attack Steps:**

1. Intercept login request
2. Decode JWT token
3. Modify header `alg` value
4. Replay request with modified token

**Result:**
Admin-level access was granted without valid credentials.

---

### 3. IDOR – Unauthorized User Data Access

**Severity:** High

**Description:**
User IDs were modified in intercepted requests, allowing access to other users’ data.

**Endpoint:**
`/api/users/{id}`

**Result:**
Server returned data belonging to other users.

---

### 4. Stored XSS Validation

**Severity:** High
**Related Finding:** HIGH-001

**Description:**
Stored XSS payload injected via feedback form and executed when viewed by other users.

**Payload:**

```html
<script>alert(document.cookie)</script>
```

**Result:**
Script executed in victim’s browser.

---

### 5. Missing Rate Limiting on Login Endpoint

**Severity:** High

**Description:**
Repeated login attempts were sent using Burp Intruder without restriction.

**Endpoint:**
`/rest/user/login`

**Result:**
No rate limiting or lockout observed.

---

### 6. Session Fixation Issue

**Severity:** High

**Description:**
Session ID remained unchanged after successful login.

**Result:**
Session hijacking risk confirmed.

---

### 7. CSRF Token Missing

**Severity:** Medium

**Description:**
State-changing requests lacked CSRF tokens.

**Affected Endpoints:**

* `/api/feedback`
* `/rest/basket/add`

---

### 8. Verbose Error Messages

**Severity:** Medium

**Description:**
Backend stack traces were visible when malformed requests were submitted.

---

### 9. CORS Misconfiguration

**Severity:** Medium

**Description:**
CORS policy allowed wildcard origins with credentials enabled.

**Observed Header:**

```http
Access-Control-Allow-Origin: *
```

---

### 10. Insecure Cookie Attributes

**Severity:** Low

**Description:**
Cookies missing `Secure` and `HttpOnly` flags.

---

### 11. Password in GET Request

**Severity:** Low

**Description:**
Credentials observed in URL parameters during authentication attempts.

---

## Burp Suite Limitations

* Community Edition lacks automated scanning
* Manual testing requires analyst expertise
* Some findings require correlation with other tools

All findings were validated against:

* OWASP ZAP
* Nikto
* Manual code review

---

## Conclusion

Burp Suite manual testing confirmed multiple **critical and high-risk vulnerabilities** identified by automated tools and revealed additional **business logic flaws**.

Manual testing is essential to:

* Validate exploitability
* Identify logic flaws
* Reduce false positives

Burp Suite findings significantly contributed to the overall risk assessment.

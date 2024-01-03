# V-235149 - The MySQL Database Server 8.0 must uniquely identify and authenticate non-organizational users (or processes acting on behalf of non-organizational users).

**Severity**: medium

**Description**:
Non-organizational users include all information system users other than organizational users, which include organizational employees or individuals the organization deems to have equivalent status of employees (e.g., contractors, guest researchers, individuals from allied nations). 

Non-organizational users will be uniquely identified and authenticated for all accesses other than those accesses explicitly identified and documented by the organization when related to the use of anonymous access, such as accessing a web server.  

Accordingly, a risk assessment is used in determining the authentication needs of the organization. 

Scalability, practicality, and security are simultaneously considered in balancing the need to ensure ease of use for access to federal information and information systems with the need to protect and adequately mitigate risk to organizational operations, organizational assets, individuals, other organizations, and the Nation.

**Fix Text**:
```Configure MySQL Database Server 8\.0 settings to uniquely identify and authenticate all non\-organizational users who log on to the system\.

Ensure all logins are uniquely identifiable and authenticate all non\-organizational users who log on to the system\. This likely would be done by ensuring mapping of MySQL accounts to individual accounts\. Verify server documentation to ensure accounts are documented and unique\.```

**Check Text**:
```Review MySQL Database Server 8.0 settings to determine if users uniquely identify and authenticate all non-organizational users who log on to the system.

select host, user FROM mysql.user WHERE user not in ('mysql.infoschema', 'mysql.session', 'mysql.sys');

If accounts are determined to be shared, determine if individuals are first individually authenticated. 

If the documentation indicates that this is a public-facing, read-only (from the point of view of public users) database that does not require individual authentication, this is not a finding. 

If non-organizational users are not uniquely identified and authenticated, this is a finding.```

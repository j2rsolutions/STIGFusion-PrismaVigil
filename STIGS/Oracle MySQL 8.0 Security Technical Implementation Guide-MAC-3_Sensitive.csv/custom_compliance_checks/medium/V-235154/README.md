# V-235154 - The MySQL Database Server 8.0 must maintain the authenticity of communications sessions by guarding against man-in-the-middle attacks that guess at Session ID values.

**Severity**: medium

**Description**:
One class of man-in-the-middle, or session hijacking, attack involves the adversary guessing at valid session identifiers based on patterns in identifiers already known.

The preferred technique for thwarting guesses at Session IDs is the generation of unique session identifiers using a FIPS 140-2 or 140-3 approved random number generator.

However, it is recognized that available DBMS products do not all implement the preferred technique yet may have other protections against session hijacking. Therefore, other techniques are acceptable, provided they are demonstrated to be effective.

**Fix Text**:
```Connect as a mysql administrator 
mysql> set persist require\_secure\_transport=ON;

Turn on MySQL FIPS mode \(ON or STRICT\)  and restart mysqld
Edit my\.cnf
\[mysqld\]
ssl\_fips\_mode=ON
or
ssl\_fips\_mode=STRICT```

**Check Text**:
```Determine if MySQL is configured to require SSL.  

SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables
WHERE VARIABLE_NAME like 'require_secure_transport';

If require_secure_transport is not "ON", this is a finding.

Determine if MySQL is configured to require the use of FIPS compliant algorithms. 

SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables
WHERE VARIABLE_NAME = 'ssl_fips_mode';

If ssl_fips_mode is not "ON", this is a finding.```

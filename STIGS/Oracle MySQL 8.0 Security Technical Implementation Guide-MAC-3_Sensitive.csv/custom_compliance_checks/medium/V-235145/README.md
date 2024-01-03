# V-235145 - Unused database components which are integrated in the MySQL Database Server 8.0 and cannot be uninstalled must be disabled.

**Severity**: medium

**Description**:
Information systems are capable of providing a wide variety of functions and services. Some of the functions and services, provided by default, may not be necessary to support essential organizational operations (e.g., key missions, functions).  

It is detrimental for software products to provide, or install by default, functionality exceeding requirements or mission objectives.  

Database Management Systems (DBMSs) must adhere to the principles of least functionality by providing only essential capabilities.

Unused, unnecessary DBMS components increase the attack vector for the DBMS by introducing additional targets for attack. By minimizing the services and applications installed on the system, the number of potential vulnerabilities is reduced. Components of the system that are unused and cannot be uninstalled must be disabled. The techniques available for disabling components will vary by DBMS product, OS and the nature of the component and may include DBMS configuration settings, OS service settings, OS file access security, and DBMS user/group permissions.

**Fix Text**:
```Uninstall unused components or features that are installed and can be uninstalled\. Remove any database objects and applications that are installed to support them\.

After review of installed plugin components uninstall unused plugins\. To do this while the server is running using the UNINSTALL PLUGIN; command: 

Remove any plugin that is loaded at startup from the my\.cnf file\.

For example \- ddl\_rewriter is discovered but are not being used\.  Follow these removal instructions\.
Remove this line from my\.cnf:
plugin\-load\-add=ddl\_rewriter\.so

Remove any plugin that is not loaded at startup using the \-\-plugin\-load parameter from the my\.cnf or on the command line\. 
UNINSTALL PLUGIN <plugin\_name>;
UNINSTALL PLUGIN ddl\_rewriter;

Remove any component not in use
UNINSTALL COMPONENT component\_name \[, component\_name \] \.\.\.;

For example \- The audit message emit function is not being called, the component is not needed\.  
UNINSTALL COMPONENT "file://component\_audit\_api\_message\_emit";```

**Check Text**:
```Review the list of components and features installed with the MySQL Database Server 8.0.

List options MySQL Plugins/Components

SELECT * FROM information_schema.PLUGINS where plugin_library is NOT NULL;

Compare the feature listing against the required plugins listing. 

If any plugins are installed, but are not required, this is a finding.

SELECT * FROM mysql.component;

Compare the feature listing against the required components listing. 

If any components are installed, but are not required, this is a finding.```

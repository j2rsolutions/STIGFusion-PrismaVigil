# STIG_Apache2.4_processes_allowed_programs

## Type
processes

## Description
Detects the launching of unauthorized software on the web server, aligned with Apache STIG 2.4 finding V-214240. The rule alerts upon execution of non-essential processes, addressing security and compliance concerns.

## Alert Message
Unauthorized Software Launch %proc.name Detected  on Web Server (STIG ID: V-214240). This alert indicates the execution of software not authorized for the web server environment, potentially violating Apache STIG 2.4 finding V-214240. Immediate attention is required to ensure only essential software for web server operation is active.

## Rule Script
proc.name != "adduser" and proc.name != "apt" and proc.name != "base-files" and proc.name != "base-passwd" and proc.name != "bash" and proc.name != "bsdutils" and proc.name != "ca-certificates" and proc.name != "coreutils" and proc.name != "dash" and proc.name != "debconf" and proc.name != "debian-archive-keyring" and proc.name != "debianutils" and proc.name != "diffutils" and proc.name != "dpkg" and proc.name != "e2fsprogs" and proc.name != "findutils" and proc.name != "gpgv" and proc.name != "grep" and proc.name != "gzip" and proc.name != "hostname" and proc.name != "init-system-helpers" and proc.name != "libaudit-common" and proc.name != "libc-bin" and proc.name != "libc-dev-bin" and proc.name != "libldap-common" and proc.name != "libpam-modules-bin" and proc.name != "libpam-runtime" and proc.name != "libsemanage-common" and proc.name != "libtirpc-common" and proc.name != "login" and proc.name != "logsave" and proc.name != "mawk" and proc.name != "mount" and proc.name != "ncurses-base" and proc.name != "ncurses-bin" and proc.name != "openssl" and proc.name != "passwd" and proc.name != "perl-base" and proc.name != "rpcsvc-proto" and proc.name != "sed" and proc.name != "sysvinit-utils" and proc.name != "tar" and proc.name != "tzdata" and proc.name != "usr-is-merged" and proc.name != "util-linux" and proc.name != "util-linux-extra"

## STIG References
This rule is particularly relevant to STIG Finding V-214245, which addresses the security management of Apache2 configurations.

- [STIG apache_server_2.4_unix_server - Finding ID: V-214240](https://github.com/j2rsolutions/STIGFusion-PrismaVigil/tree/main/STIGS/apache_server_2.4_unix_server/custom_compliance_checks/medium/V-214240/scripts)

## Rule Information
- **Owner:** jonathan
- **Last Modified:** 1704474047
- **Attack Techniques:** None specified

## Usage
This rule is designed to be implemented in environments that align with Apache STIG 2.4 requirements. Ensure it is configured correctly in your monitoring system.

## License
Specify the license under which this rule is released (if applicable).

## Contributing
Contributions to enhance this rule are welcome. Please adhere to standard coding practices and provide thorough documentation of any changes.

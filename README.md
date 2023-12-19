# STIGFUSION-PRISMAVIGIL

## Overview
STIGFUSION-PRISMAVIGIL is a collection of Prisma Cloud Compute custom compliance checks and runtime rules, aimed at supporting development efforts in addressing DISA STIGs. This project focuses on identifying runtime deviations and anomalous activities in development environments.

![DISA STIG](images/disa_stig.png) ➡️ ![Prisma Cloud](images/prisma_cloud.png)

## Project Structure
The project is organized into two primary directories at the root level:

- `scripts`
- `stigs`

### STIGs Directory
Within the `stigs` directory, there are subdirectories for specific STIGs, each containing:

- `custom_compliance_checks`
- `custom_runtime_rules`

#### Custom Compliance Checks
These checks are mapped directly to corresponding DISA STIG rules and are essential for aligning development with compliance standards.

#### Custom Runtime Rules
The runtime rules reference related STIGs and follow the naming format `STIG_{stig_name}_{custom_runtime_rule_type}_{description_of_rule}`. They are designed to detect runtime events, offering insights into compliance adherence during runtime.

## Python Script for Prisma Cloud API Interaction
An integral part of this project is a Python script designed to interact with the Prisma Cloud API. This script facilitates the loading of custom compliance and runtime rules, and also provides a functionality to convert raw rules into a structured, importable format. Key functionalities include:

- Perform a container scan (`-cs` / `--containerscan`)
- Retrieve custom compliance checks (`-gcc` / `--get_custom_compliance`)
- Update custom compliance rules from a file (`-ucc` / `--updatecustomcompliance`)
- Update custom runtime rules from a file (`-ucr` / `--updatecustomruntimerules`)
- Retrieve custom runtime rules (`-gcr` / `--get_custom_runtime_rules`)
- Convert raw rules into importable format (`-convert` followed by necessary rule details) *(in development)*
- Set the console hostname (`-c` / `--console`)
- Specify the API version, defaulting to 32.00 (`-v` / `--version`)
- STAGE/Convert a CSV file to a Markdown table in README.md using DISA STIG CSV.  Used for tracking status of custom runtime rule development and mapping to STIG(`-csv` / `--csv_to_markdown`)
- Convert raw custom runtime rule from a file to JSON for import (`-cr2j` / `--convert_runtime_2_json`)
    - `NAME`: The name of the custom runtime rule.
    - `RAW_RULE_FILE`: The file path to the raw rule.
    - `DESCRIPTION`: A brief description of the rule.
    - `MESSAGE`: The message or alert that will be displayed when the rule is triggered.
    - `OWNER`: The owner of the rule.
    - `MIN_VERSION`: The minimum version of the API required for this rule.
    - `POLICY_TYPE`: The type of policy the rule falls under.
    - `ATTACK_TECHNIQUES`: Related attack techniques:
        - ["exploitationForPrivilegeEscalation", "exploitPublicFacingApplication",
        - "applicationExploitRCE", "networkServiceScanning",
        - "endpointDenialOfService", "exfiltrationGeneral",
        - "systemNetworkConfigurationDiscovery", "unsecuredCredentials",
        - "credentialDumping", "systemInformationDiscovery",
        - "systemNetworkConnectionDiscovery", "systemUserDiscovery",
        - "accountDiscovery", "cloudInstanceMetadataAPI",
        - "accessKubeletMainAPI", "queryKubeletReadonlyAPI",
        - "accessKubernetesAPIServer", "softwareDeploymentTools",
        - "ingressToolTransfer", "lateralToolTransfer",
        - "commandAndControlGeneral", "resourceHijacking",
        - "manInTheMiddle", "nativeBinaryExecution",
        - "foreignBinaryExecution", "createAccount",
        - "accountManipulation", "abuseElevationControlMechanisms",
        - "supplyChainCompromise", "obfuscatedFiles",
        - "hijackExecutionFlow", "impairDefences",
        - "scheduledTaskJob", "exploitationOfRemoteServices",
        - "eventTriggeredExecution", "accountAccessRemoval",
        - "privilegedContainer", "writableVolumes",
        - "execIntoContainer", "softwareDiscovery",
        - "createContainer", "kubernetesSecrets",
        - "fileAndDirectoryDiscovery", "masquerading",
        - "webShell", "compileAfterDelivery"]




### Example 1: Performing a Container Scan

#### Performing a Container Scan

To perform a container scan, use the `-cs` flag along with the required console hostname and version

python prismavigil.py -cs -c [console_hostname] -v [version]


You will be prompted to enter your username and password. After authentication, the script will perform a container scan and display the results.

Replace `[console_hostname]` and `[version]` with your actual console hostname and API version.

**Example:**

`python prismavigil.py -cs -c console.example.com -v 32.00`



### Example 2: Getting Custom Compliance Checks

#### Getting Custom Compliance Checks

To retrieve custom compliance checks, use the `-gcc` flag with the console hostname and version:


python prismavigil.py -gcc -c [console_hostname] -v [version]


After entering your credentials, the script will fetch and display the custom compliance checks.

**Example:**

`python prismavigil.py -gcc -c console.example.com -v 32.00`



### Example 3: Updating Custom Runtime Rules

#### Updating Custom Runtime Rules

To update custom runtime rules from a file, use the `-ucr` flag. You need to provide the file path, console hostname, and version:


python prismavigil.py -ucr -c [console_hostname] -v [version] -ucc path/to/your_rule_file.json


The script will prompt for your username and password, then proceed to update the custom runtime rules based on the provided file.

**Example:**

`python prismavigil.py -ucr -c console.example.com -v 32.00 -ucc /path/to/rules.json`


Note: Replace `[console_hostname]`, `[version]`, and `path/to/your_rule_file.json` with the appropriate values.

### Example 4: Convert custom runtime rule raw to importable json

#### Convert Runtime rule

**Example:**

To convert a rule named "ExampleRule" located in "example_rule.txt", with a description "Sample rule", displaying the message "Alert triggered", owned by "user", requiring a minimum API version of "32.00", classified under "Access Control" policy type, and related to "Injection attacks" technique:

```
python prismavigil.py -cr2j --convert_runtime_2_json "ExampleRule" "example_rule.txt" "Sample rule" "Alert triggered" "user" "32.00" "Access Control" "Injection attacks"
```



## Getting Started
To use STIGFUSION-PRISMAVIGIL, clone the repository and navigate through the `scripts` and `stigs` directories. The Python script can be used for efficient interaction with the Prisma Cloud environment, as well as for converting raw rule definitions into a structured format suitable for import.

## Contributing
We encourage contributions that align with the project's goal of supporting development efforts in compliance and security. Please follow the established naming conventions and provide thorough documentation for your contributions.

## License
Opensource use at own risk

*Supporting development efforts in compliance and security monitoring within Prisma Cloud Compute environments.*

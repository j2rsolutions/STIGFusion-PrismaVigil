
# STIGFUSION-PRISMAVIGIL

## Overview
STIGFUSION-PRISMAVIGIL is a comprehensive collection of Prisma Cloud Compute custom compliance checks and runtime rules designed to support development efforts in meeting DISA STIG requirements. This project is dedicated to identifying and addressing runtime deviations and potential security anomalies within development environments.

## Project Structure
The project is organized into the following primary directories at the root level:

- `scripts`: Contains scripts for Prisma Cloud API interaction and utility functions.
- `stigs`: Contains subdirectories for specific STIGs, with custom compliance checks and runtime rules.

### STIGs Directory
Each subdirectory within `stigs` is dedicated to a particular STIG and includes:

- `custom_compliance_checks`: Mapped directly to DISA STIG rules to ensure compliance.
- `custom_runtime_rules`: Designed to detect runtime events, providing insights into compliance adherence.

## Python Script for Prisma Cloud API Interaction
The Python script is an essential tool for interacting with the Prisma Cloud API, enabling the automation of compliance and runtime rule management. The script includes the following capabilities:

- Perform container scans (`-cs` / `--containerscan`)
- Retrieve custom compliance checks (`-gcc` / `--get_custom_compliance`)
- Update custom compliance rules from a file (`-ucc` / `--updatecustomcompliance`)
- Update custom runtime rules from a file (`-ucr` / `--updatecustomruntimerules`)
- Retrieve custom runtime rules (`-gcr` / `--get_custom_runtime_rules`)
- Convert raw rules into importable JSON format (`-cr2jf` / `--convert_runtime_2_json_file`)
- Set the console hostname (`-c` / `--console`)
- Specify the API version, defaulting to 32.00 (`-v` / `--version`)
- Convert a CSV file to a Markdown table for tracking and mapping custom runtime rule development (`-csv` / `--csv_to_markdown`)
- Stage custom compliance checks for development from a CSV file (`-sccc` / `--stage_custom_compliance_checks`)

#### Argument Details
- `-sccc` / `--stage_custom_compliance_checks`: This argument takes a CSV file as input and stages custom compliance checks for collaborative development. It's a crucial step for teams to update and track compliance status in a structured manner.


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

## Staging of STIG CSV Files for Collaboration and Table Mapping

To streamline the process of developing and tracking STIG compliance within our development environment, we've established a collaborative framework using STIG CSV files. This framework enables our team to systematically develop, track, and map custom runtime rules to specific STIG findings, ensuring continuous compliance and security.

### Workflow Overview

1. **Download STIG Findings CSV**: Obtain the latest CSV file containing STIG findings from official sources like [STIG Viewer](https://www.stigviewer.com/stig/apache_server_2.4_unix_server/2023-06-08/MAC-3_Sensitive/excel).

2. **Add Tracking Columns**: Enhance the CSV by adding the following columns to track the development of compliance and runtime rules:
   - Custom Compliance Check
   - Custom Runtime Rule
   - Status
   - Assigned To
   - Link to Issue

3. **Update and Collaborate**: As custom compliance checks and runtime rules are developed, the CSV file serves as the central tracking system. Team members can update the status and assignees, fostering transparency and collaboration.

4. **Convert CSV to Markdown**: Utilize the `--csv_to_markdown` flag in `prismavigil.py` to convert the updated CSV file into a Markdown table format. This table can then be incorporated into the `README.md` for a clear and accessible display of the project's compliance status.

### Example Workflow: Apache Server STIG

1. **Download the CSV**: Fetch the Apache Server 2.4 UNIX Server STIG findings from the provided [link](https://www.stigviewer.com/stig/apache_server_2.4_unix_server/2023-06-08/MAC-3_Sensitive/excel).

2. **Enhance with Columns**: Add the required columns to the downloaded CSV for tracking purposes.

3. **Develop Custom Rules**: Create custom compliance checks and runtime rules corresponding to the STIG findings.

4. **Update CSV**: Reflect the development progress within the CSV file by updating the custom checks, rules, and statuses.

5. **Convert and Integrate**: Run the Python script with the `--csv_to_markdown` flag to convert the CSV into a Markdown table, and integrate this into the `README.md` file.

```sh
python prismavigil.py --csv_to_markdown path/to/your_stig_file.csv
```

This process not only facilitates effective collaboration among the development team but also ensures that all custom rules are adequately documented and tracked against their corresponding STIG findings.

Once you have converted the updated csv to markdown table or updated the existing, do your normal git add commit push steps appropriate for your team.


## Getting Started
To use STIGFUSION-PRISMAVIGIL, clone the repository and navigate through the `scripts` and `stigs` directories. The Python script can be used for efficient interaction with the Prisma Cloud environment, as well as for converting raw rule definitions into a structured format suitable for import.

## Contributing
We encourage contributions that align with the project's goal of supporting development efforts in compliance and security. Please follow the established naming conventions and provide thorough documentation for your contributions.

## License
Opensource use at own risk

*Supporting development efforts in compliance and security monitoring within Prisma Cloud Compute environments.*

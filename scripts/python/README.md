## Python Script for Prisma Cloud API Interaction
The Python script is an essential tool for interacting with the Prisma Cloud API, enabling the automation of compliance and runtime rule management. The script includes the following capabilities:

- Perform container scans (`-cs` / `--containerscan`)
- Retrieve custom compliance checks (`-gcc` / `--get_custom_compliance`)
- Update custom compliance rules from a file (`-ucc` / `--updatecustomcompliance`)
- Update custom runtime rules from a file (`-ucr` / `--updatecustomruntimerules`)
- Retrieve custom runtime rules (`-gcr` / `--get_custom_runtime_rules`)
- Convert raw rules into importable JSON format (`-cr2jf` / `--convert_runtime_2_json_file`)
- Set the console hostname (Please include port in `hostname:port` if console is published on non traditional web port 80 or 443) (`-c` / `--console`)
- Specify the API version, defaulting to 32.00 (`-v` / `--version`)
- Convert a CSV file to a Markdown table for tracking and mapping custom runtime rule development (`-csv` / `--csv_to_markdown`)
- Stage custom compliance checks for development from a CSV file (`-sccc` / `--stage_custom_compliance_checks`)
- Convert software list to runtime rule (`-cvrtsft` / `--convert_software_list_to_runtime_rule`)
- Convert runtime rule to README format (`-cvrtread` / `--convert_runtime_rule_to_readme`)


### Installation of PrismaVigil in PATH
To install `prismavigil.py` in your system's PATH for easy execution without needing to prefix commands with `python` or `python3`, use one of the following scripts from the `bash` directory:
- `install_prisma_vigil_system_wide.sh`: For system-wide installation, making `prismavigil.py` accessible to all users. This requires administrative privileges.
- `install_prisma_vigil_user_local.sh`: For user-local installation, making `prismavigil.py` accessible only to the current user without administrative privileges.

**System-Wide Installation:**
1. Navigate to the `bash` directory.
2. Run `sudo ./install_prisma_vigil_system_wide.sh`.

**User-Local Installation:**
1. Navigate to the `bash` directory.
2. Run `./install_prisma_vigil_user_local.sh`.

These scripts will set up `prismavigil.py` so that you can run it directly from the terminal using the command `prismavigil`.

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




### Example 4: Convert Custom Runtime Rule to Importable JSON

#### Convert Runtime Rule

To convert a raw custom runtime rule to an importable JSON format, the script now requires only two arguments: the file containing the raw rule and the `rulemeta.json` file which includes the metadata for the rule.

**Example:**

Assuming you have a raw rule definition in `example_rule.txt` and the metadata for the rule is specified in `rulemeta.json`, the command to convert it to JSON is as follows:

```sh
python prismavigil.py --convert_runtime_2_json_file path/to/example_rule.txt path/to/rulemeta.json
```

The `rulemeta.json` file should be structured with the necessary fields such as `name`, `_id`, `description`, `message`, `owner`, `minVersion`, `policyType`, and `attackTechniques`. Here's an example of what `rulemeta.json` might look like:

```json
{
  "name": "ExampleRule",
  "_id": "51",
  "description": "Sample rule description that matches the STIG requirements.",
  "message": "Alert triggered for ExampleRule.",
  "owner": "user",
  "minVersion": "32.00",
  "policyType": "Access Control",
  "attackTechniques": [
    "Injection attacks"
  ]
}
```

### Example 5: Convert Software List to Runtime Rule
To specify a list of software allowed to run, and export a custom runtime rule, use the following command:

```sh
python prismavigil.py --convert_software_list_to_runtime_rule path/to/input_file.txt path/to/output_file.json
```

### Example 6: Convert Runtime Rule to README Format
To convert a JSON runtime rule into a README.md format for your Git Repository, use:

```sh
python prismavigil.py --convert_runtime_rule_to_readme path/to/your_runtime_rule.json
```

The script will parse the `rulemeta.json` and the raw rule file, then generate a JSON file that is properly formatted and ready for import into the Prisma Cloud environment.

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






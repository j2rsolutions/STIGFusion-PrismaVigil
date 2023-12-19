import argparse
import http
import requests
import urllib3
import json
import time
import os
from getpass import getpass
import csv

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

ALLOWED_ATTACK_TECHNIQUES = set(["exploitationForPrivilegeEscalation", "exploitPublicFacingApplication", "applicationExploitRCE", "networkServiceScanning", "endpointDenialOfService", "exfiltrationGeneral", "systemNetworkConfigurationDiscovery", "unsecuredCredentials", "credentialDumping", "systemInformationDiscovery", "systemNetworkConnectionDiscovery", "systemUserDiscovery", "accountDiscovery", "cloudInstanceMetadataAPI", "accessKubeletMainAPI", "queryKubeletReadonlyAPI", "accessKubernetesAPIServer", "softwareDeploymentTools", "ingressToolTransfer", "lateralToolTransfer", "commandAndControlGeneral", "resourceHijacking", "manInTheMiddle", "nativeBinaryExecution", "foreignBinaryExecution", "createAccount", "accountManipulation", "abuseElevationControlMechanisms", "supplyChainCompromise", "obfuscatedFiles", "hijackExecutionFlow", "impairDefences", "scheduledTaskJob", "exploitationOfRemoteServices", "eventTriggeredExecution", "accountAccessRemoval", "privilegedContainer", "writableVolumes", "execIntoContainer", "softwareDiscovery", "createContainer", "kubernetesSecrets", "fileAndDirectoryDiscovery", "masquerading", "webShell", "compileAfterDelivery"])

def convert_to_importable_rule(name, raw_rule, description, message, owner, attack_techniques, id=None, min_version="", vuln_ids=None, usages=None, policy_type="customRules"):
    """
    Convert a raw rule into an importable rule format.
    """
    if id is None:
        id = int(time.time())

    if vuln_ids is None:
        vuln_ids = []

    if usages is None:
        usages = []
        
    importable_rule = {
        "_id": id,
        "name": name,
        "type": "processes",
        "script": f"{raw_rule}\n\n//Implementation Notes:\n{description}",
        "description": description,
        "message": message,
        "owner": owner,
        "modified": int(time.time()),
        "minVersion": min_version,
        "vulnIDs": vuln_ids if vuln_ids is not None else [],
        "usages": usages if usages is not None else [],
        "policyType": policy_type,
        "exportTime": time.strftime("%x, %X"),
        "exportBy": owner,
        "attackTechniques": []
    }

    # Validate and add attackTechniques
    if not set(attack_techniques).issubset(ALLOWED_ATTACK_TECHNIQUES):
        raise ValueError("Invalid attack technique(s) provided.")
    importable_rule["attackTechniques"] = attack_techniques



    return importable_rule

# Function to perform container scan
def container_scan(console, version, username, password):
    url = f"https://{console}/api/v{version}/containers/scan"
    response = requests.post(url, auth=(username, password), verify=False, headers={'Content-Type': 'application/json'})
    return response.text

# Function to get custom rules
def get_custom_compliance(console, version, username, password):
    url = f"https://{console}/api/v{version}/custom-compliance"
    response = requests.get(url, auth=(username, password), verify=False, headers={'Content-Type': 'application/json'})
    return response.text

# Function to update custom compliance rules
def update_custom_compliance(console, version, username, password, file_path):
    url = f"https://{console}/api/v{version}/custom-compliance"
    with open(file_path, 'r') as file:
        data = json.load(file)
        for rule in data:
            response = requests.put(url, auth=(username, password), json=rule, verify=False, headers={'Content-Type': 'application/json'})
            print(f"Updating rule {rule['name']}: {response.status_code} - {response.text}")


def update_custom_runtime_rules(console, version, username, password, file_path):
    with open(file_path, 'r') as file:
        try:
            data = json.load(file)
        except json.JSONDecodeError:
            print(f"Error: Failed to decode JSON from {file_path}")
            return

        # If the data is a dictionary, convert it into a list
        if isinstance(data, dict):
            data = [data]

        if not isinstance(data, list):
            print(f"Error: JSON data in {file_path} is neither a list nor a valid dictionary")
            return

        for rule in data:
            if not isinstance(rule, dict) or '_id' not in rule:
                print(f"Error: Invalid rule format or missing '_id' in rule {rule}")
                continue

            rule_id = rule['_id']
            update_url = f"https://{console}/api/v{version}/custom-rules/{rule_id}"

            response = requests.put(update_url, auth=(username, password), json=rule, verify=False, headers={'Content-Type': 'application/json'})
            print(f"Updating rule {rule.get('name', 'Unknown')} (ID: {rule_id}): {response.status_code} - {response.text}")



def get_custom_runtime_rules(console, version, username, password):
    url = f"https://{console}/api/v{version}/custom-rules"
    print(f"Retrieving Custom Rules from: {url}")
    response = requests.get(url, auth=(username, password), verify=False, headers={'Content-Type': 'application/json'})

    print(f"Status Code: {response.status_code}")

    if response.status_code == 200:
        # Parse the JSON response and then pretty-print it
        parsed_json = json.loads(response.text)
        pretty_json = json.dumps(parsed_json, indent=4, sort_keys=True)
        print(pretty_json)
        return pretty_json
    else:
        print(f"Error: {response.status_code} - {response.text}")
        return f"Error: {response.status_code} - {response.text}"

def csv_to_markdown_table(csv_file):
    try:
        with open(csv_file, mode='r', encoding='utf-8') as file:
            reader = csv.DictReader(file)
            fields = reader.fieldnames

            # Check if required columns are present in the CSV
            required_columns = ['id', 'severity', 'title', 'description']
            additional_columns = ['Custom Runtime Rule', 'Status', 'Assigned To', 'Link to Issue']
            all_columns = required_columns + additional_columns

            if not all(col in fields for col in all_columns):
                raise ValueError("CSV must have id, severity, title, description, Custom Runtime Rule, Status, Assigned To, and Link to Issue columns.")

            # Extract the filename without extension
            filename_without_extension = os.path.splitext(os.path.basename(csv_file))[0]

            with open('README.md', mode='w', encoding='utf-8') as mdfile:
                # Write the filename as a header
                mdfile.write(f"# {filename_without_extension}\n\n")

                # Write the headers
                mdfile.write('| ' + ' | '.join(all_columns) + ' |\n')
                mdfile.write('|' + '|'.join(['---' for _ in all_columns]) + '|\n')

                # Write the rows
                for row in reader:
                    # Replace newlines with HTML <br> tags in the description field
                    row['description'] = row['description'].replace('\n', '<br>')
                    
                    # Fill in default values for additional columns if blank
                    row_values = [row.get(col, 'TBD' if col in additional_columns else '') for col in all_columns]
                    mdfile.write('| ' + ' | '.join(row_values) + ' |\n')

        print(f"Markdown table has been successfully written to README.md with header '{filename_without_extension}'")
    except FileNotFoundError:
        print(f"Error: File '{csv_file}' not found.")
    except ValueError as e:
        print(e)


def stage_custom_compliance_checks(csv_file, base_directory="custom_compliance_checks"):
    # Ensure base directory exists
    if not os.path.exists(base_directory):
        os.makedirs(base_directory)

    with open(csv_file, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        
        for row in reader:
            # Create directory structure
            severity_path = os.path.join(base_directory, row['severity'])
            id_path = os.path.join(severity_path, row['id'])
            os.makedirs(id_path, exist_ok=True)
            fixtext_escaped = escape_markdown(row['fixtext'])
            # Write the README.md file
            readme_content = f"# {row['id']} - {row['title']}\n\n" \
                             f"**Severity**: {row['severity']}\n\n" \
                             f"**Description**:\n{row['description']}\n\n" \
                             f"**Fix Text**:\n```{fixtext_escaped}```\n\n" \
                             f"**Check Text**:\n```{row['checktext']}```\n"

            with open(os.path.join(id_path, "README.md"), mode='w', encoding='utf-8') as readme_file:
                readme_file.write(readme_content)
            print(f"Created README.md for {row['id']} in {id_path}")


def escape_markdown(text):
    markdown_characters = r"\`*_{}[]()#+-.!|"
    for char in markdown_characters:
        text = text.replace(char, "\\" + char)
    return text


# Main function
def main():
    parser = argparse.ArgumentParser(description="API Call Script")
    parser.add_argument('-cs', '--containerscan', action='store_true', help='Perform a container scan')
    parser.add_argument('-gcc', '--get_custom_compliance', action='store_true', help='Get custom compliance checks (not the same as runtime rules)')
    parser.add_argument('-c', '--console', required=True, help='Console hostname')
    parser.add_argument('-v', '--version', default='32.00', help='API version (default: 32.00)')
    parser.add_argument('-ucc', '--updatecustomcompliance', help='Update custom compliance rules from a file', metavar='FILE')
    parser.add_argument('-ucr', '--updatecustomruntimerules', help='Update custom runtime rules from a file', metavar='FILE')
    parser.add_argument('-gcr', '--get_custom_runtime_rules', action='store_true', help='Get custom runtime rules')
    parser.add_argument('-cr2j', '--convert_runtime_2_json', nargs=8, metavar=('NAME', 'RAW_RULE_FILE', 'DESCRIPTION', 'MESSAGE', 'OWNER', 'MIN_VERSION', 'POLICY_TYPE', 'ATTACK_TECHNIQUES'), help='Convert raw custom runtime rule from a file to json for import')
    parser.add_argument('-csv', '--csv_to_markdown', help='Convert CSV file to Markdown table', metavar='CSV_FILE')
    parser.add_argument('-sccc', '--stage_custom_compliance_checks', help='Stage custom compliance checks from a CSV file', metavar='CSV_FILE')

    args = parser.parse_args()

    username = input("Enter username: ")
    password = getpass("Enter password: ")


    if args.stage_custom_compliance_checks:
            stage_custom_compliance_checks(args.stage_custom_compliance_checks)

    elif args.csv_to_markdown:
        csv_to_markdown_table(args.csv_to_markdown)

    elif args.convert_runtime_2_json:
        name, raw_rule_file, description, message, owner, min_version, policy_type, attack_techniques_str = args.convert_runtime_2_json
        
        attack_techniques = attack_techniques_str.split(',')

        # Check if the file exists
        if not os.path.isfile(raw_rule_file):
            print(f"Error: The file {raw_rule_file} does not exist.")
            return

        # Read raw rule from the file
        with open(raw_rule_file, 'r') as file:
            raw_rule = file.read()

        converted_rule = convert_to_importable_rule(name, raw_rule, description, message, owner, attack_techniques, min_version, policy_type)
        print(json.dumps(converted_rule, indent=4))

    elif args.containerscan:
        response = container_scan(args.console, args.version, username, password)
        print(response)
    elif args.get_custom_compliance:
        response = get_custom_compliance(args.console, args.version, username, password)
        print(response)
    elif args.updatecustomcompliance:
        update_custom_compliance(args.console, args.version, username, password, args.updatecustomcompliance)
    elif args.updatecustomruntimerules:
        update_custom_runtime_rules(args.console, args.version, username, password, args.updatecustomruntimerules)
    elif args.get_custom_runtime_rules:
        get_custom_runtime_rules(args.console, args.version, username, password)

if __name__ == "__main__":
    main()




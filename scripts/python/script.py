import argparse
import http
import requests
import urllib3
import json
from getpass import getpass

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


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
        data = json.load(file)
        for rule in data:
            # Ensure the rule contains an '_id' field
            if '_id' not in rule:
                print(f"Error: Rule '{rule.get('name', 'Unknown')}' does not contain an '_id' field.")
                continue
            
            rule_id = rule['_id']
            update_url = f"https://{console}/api/v{version}/custom-rules/{rule_id}"

            response = requests.put(update_url, auth=(username, password), json=rule, verify=False, headers={'Content-Type': 'application/json'})
            print(f"Updating rule {rule['name']} (ID: {rule_id}): {response.status_code} - {response.text}")


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
    
    args = parser.parse_args()

    username = input("Enter username: ")
    password = getpass("Enter password: ")

    if args.containerscan:
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




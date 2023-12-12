import time
import json

def convert_to_importable_rule(name, raw_rule, description, message, owner, id=None, min_version="", vuln_ids=None, usages=None, policy_type="customRules"):
    """
    Convert a raw rule into an importable rule format.

    :param name: Name of the rule.
    :param raw_rule: Raw rule string.
    :param description: Description of the rule.
    :param message: Alert message for the rule.
    :param owner: Owner of the rule.
    :param id: Optional ID for the rule.
    :param min_version: Minimum version required.
    :param vuln_ids: Vulnerability IDs associated with the rule.
    :param usages: Usages of the rule.
    :param policy_type: Type of the policy.
    :return: Dict representing the importable rule.
    """
    if id is None:
        id = int(time.time())  # Use current timestamp as a unique ID

    if vuln_ids is None:
        vuln_ids = []

    if usages is None:
        usages = []

    importable_rule = {
        "name": name,
        "_id": id,
        "type": "processes",
        "script": f"{raw_rule}\n\n//Implementation Notes:\n{description}",
        "description": description,
        "message": message,
        "owner": owner,
        "modified": int(time.time()),
        "minVersion": min_version,
        "vulnIDs": vuln_ids,
        "usages": usages,
        "policyType": policy_type,
        "exportTime": time.strftime("%x, %X"),
        "exportBy": owner
    }

    return importable_rule

# Example usage
raw_rule = "proc.cmdline contains \"passwd -u\""
description = "This custom runtime rule is designed to monitor and alert on any changes to the Apache service account's login shell or password status..."
message = "Potential Compliance Deviation Detected: An action has been observed that might alter the login shell or password of the Apache service account..."
owner = "jonathan"

importable_rule = convert_to_importable_rule("STIG_Apache2.4_ServiceAccount_ShellAndPassword", raw_rule, description, message, owner)
print(json.dumps(importable_rule, indent=2))

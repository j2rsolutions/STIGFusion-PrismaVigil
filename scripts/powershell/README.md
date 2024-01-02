## PowerShell Installation Script for Windows

### Overview
The provided PowerShell script automates the installation of `prismavigil.py` on Windows systems. It creates a wrapper for the Python script, allowing it to be executed directly from PowerShell.

### Prerequisites
- Ensure Python 3 is installed and accessible from the PATH in Windows.
- PowerShell execution policies might need to be adjusted to allow script execution.

### Script Functionality
- Creates a `bin` directory in the user's profile directory if it doesn't exist.
- Adds the `bin` directory to the user's PATH environment variable.
- Copies `prismavigil.py` to the `bin` directory.
- Creates a PowerShell wrapper script (`prismavigil.ps1`) that invokes the Python script.
- Modifies execution policies to allow running local scripts (for the current user only).

### Running the Script
1. Save the script as `install_prismavigil.ps1` in the project's directory.
2. Open PowerShell and navigate to the script's directory.
3. Execute the script: `.\install_prismavigil.ps1`.
4. You may need to restart PowerShell or log out and log back in for the PATH changes to take effect.

### Important Note
- This script is currently untested and should be used with caution. Users are advised to review the script thoroughly before execution.
- Users should be aware of the security implications of changing execution policies in PowerShell.
- The script assumes the relative path to `prismavigil.py` is correct. Adjust the path in the script if necessary.

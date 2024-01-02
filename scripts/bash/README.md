

# PrismaVigil Installation Script

## Overview
This script automates the installation of the `prismavigil.py` script, placing a symbolic link in `/usr/local/bin` for easy execution. This allows you to run `prismavigil` from anywhere in the terminal.

## Running the Installation Script
For system-wide installation, the script must be run with administrative privileges. Navigate to the directory containing the installation script and execute:

**To use this script:**
1. Save the above script as `install_prismavigil.sh` in the projects `./bash` directory.
2. Make it executable with `chmod +x ./bash/install_prismavigil.sh`.
3. Run the script with `sudo ./install_prismavigil.sh`.

## What the Script Does
- Checks if the `prismavigil.py` script exists in the `../python` directory relative to the installation script.
- Creates or updates a symbolic link in `/usr/local/bin` pointing to the `prismavigil.py` script.
- Makes the symlink executable, allowing the script to be run with the `prismavigil` command from any location in the terminal.

## System Requirements
- The user must have sudo privileges to create a symbolic link in `/usr/local/bin`.
- The script assumes that `/usr/local/bin` is in the system's `PATH`.

## Note
Review the script to understand the changes it will make to your system. Running scripts with `sudo` grants them administrative privileges and should be done with caution.
```

When you include these in your repository, ensure that the paths used in the scripts and documentation match the actual paths where you intend users to clone or download your repository.
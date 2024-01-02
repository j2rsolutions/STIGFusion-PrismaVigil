# PrismaVigil Installation Scripts

## Overview
These scripts automate the installation of the `prismavigil.py` script. There are two versions: one for system-wide installation, which requires administrative privileges, and one for user-local installation, which doesn't require such privileges.

## Scripts
- `install_prisma_vigil_system_wide.sh`: Installs `prismavigil.py` system-wide, placing a symbolic link in `/usr/local/bin`.
- `install_prisma_vigil_user_local.sh`: Installs `prismavigil.py` for the current user only, placing it in the user's `~/bin` directory.

## Running the Installation Scripts

### System-Wide Installation
This requires administrative privileges to create a symbolic link in `/usr/local/bin`.
1. Save the script as `install_prisma_vigil_system_wide.sh` in the project's `./bash` directory.
2. Make it executable: `chmod +x ./bash/install_prisma_vigil_system_wide.sh`.
3. Run with `sudo`: `sudo ./bash/install_prisma_vigil_system_wide.sh`.

### User-Local Installation
This does not require administrative privileges.
1. Save the script as `install_prisma_vigil_user_local.sh` in the project's `./bash` directory.
2. Make it executable: `chmod +x ./bash/install_prisma_vigil_user_local.sh`.
3. Run the script: `./bash/install_prisma_vigil_user_local.sh`.

## What the Scripts Do

### System-Wide Script
- Checks if `prismavigil.py` exists in `../python` relative to the script.
- Creates/updates a symbolic link in `/usr/local/bin`.
- Makes the symlink executable, allowing running `prismavigil` from anywhere.

### User-Local Script
- Checks if `prismavigil.py` exists in `../python` relative to the script.
- Installs the script in `~/bin` (creates the directory if it doesn't exist).
- Adds `~/bin` to the user's `PATH` if not already present.
- Allows running `prismavigil` from anywhere for the user.

## System Requirements
- For system-wide installation: `sudo` privileges are required.
- The scripts assume that the target directories are in the system's/user's `PATH`.

## Note
Review the scripts to understand the changes they will make to your system. Running scripts with `sudo` grants them administrative privileges and should be done with caution. The user-local script modifies the user's `.bashrc` to update the `PATH`, which might require a logout/login or sourcing `.bashrc` to take effect.

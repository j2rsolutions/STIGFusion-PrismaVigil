#!/bin/bash

# The target filename
filename="prismavigil.py"
wrapper_name="prismavigil"
script_path="../python/$filename"
install_path="$HOME/bin"
wrapper="$install_path/$wrapper_name"

# Create ~/bin if it doesn't exist
if [ ! -d "$install_path" ]; then
  mkdir -p "$install_path"
fi

# Check if ~/bin is in the PATH
if [[ ":$PATH:" != *":$install_path:"* ]]; then
  echo "Adding $install_path to PATH"
  # Detect the shell and choose the appropriate config file
  if [ -n "$ZSH_VERSION" ]; then
    # User is running Zsh
    config_file="$HOME/.zshrc"
  elif [ -n "$BASH_VERSION" ]; then
    # User is running Bash
    config_file="$HOME/.bashrc"
  else
    # Default to Bash if the shell is unknown
    config_file="$HOME/.bashrc"
  fi
  echo "export PATH=\$PATH:$install_path" >> "$config_file"
  export PATH="$PATH:$install_path"
  echo "Please run 'source $config_file' or log out and back in to update your PATH."
fi

# Copy the actual Python script to the target location
cp "$script_path" "$install_path"
if [ $? -ne 0 ]; then
  echo "Failed to copy '$filename' to '$install_path'. Check your permissions."
  exit 1
fi

# Create a wrapper script that invokes python3 with the script
echo "#!/bin/bash" > "$wrapper"
echo "python3 \"$install_path/$filename\" \"\$@\"" >> "$wrapper"

# Make the wrapper script executable
chmod +x "$wrapper"
echo "Script '$filename' has been installed and is executable as '$wrapper_name' from anywhere."

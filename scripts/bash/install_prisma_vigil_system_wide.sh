#!/bin/bash

# The target filename
filename="prismavigil.py"
wrapper_name="prismavigil"
script_path="../python/$filename"

# Directories to check in the PATH, ordered by preference
declare -a paths=("$HOME/bin" "/usr/local/bin" "/usr/bin")

# Find the first path in the user's PATH that exists and is writable
for path in "${paths[@]}"; do
  if [[ ":$PATH:" == *":$path:"* ]] && [ -d "$path" ] && [ -w "$path" ]; then
    target_path="$path"
    break
  fi
done

# If a path has been found
if [ -n "$target_path" ]; then
  # The full target path for the wrapper script
  wrapper="$target_path/$wrapper_name"
  
  # Copy the actual Python script to the target location
  cp "$script_path" "$target_path"
  if [ $? -ne 0 ]; then
    echo "Failed to copy '$filename' to '$target_path'. Check your permissions."
    exit 1
  fi

  # Create a wrapper script that invokes python3 with the script
  echo "#!/bin/bash" > "$wrapper"
  echo "python3 \"$target_path/$filename\" \"\$@\"" >> "$wrapper"
  
  # Make the wrapper script executable
  chmod +x "$wrapper"
  echo "Script '$filename' has been installed and is executable as '$wrapper_name'."
  echo "Please run 'source ~/.bashrc' or source '~/.zshrc'  or log out and log back in to update your PATH."


else
  echo "No suitable writable path found in your PATH environment variable."
  exit 1
fi

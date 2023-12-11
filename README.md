
# STIG to Bash Shell Custom Compliance Checks

## 🚀 Overview

Welcome to the **STIG to Bash Shell Custom Compliance Checks** repository! This project is dedicated to automating compliance checks by converting Security Technical Implementation Guides (STIGs) into executable Bash scripts.

## 🌟 Features

- **Automated Compliance Checks**: Bash scripts representing STIGs.
- **Ease of Use**: Simplified processes to deploy and execute compliance checks.
- **Python Script for Compliance Management**: Manage custom compliance checks.
- **Container Scan Integration**: On-demand container scans for real-time assessment.

## ⚙️ Python Script Usage

Our script supports several command-line arguments for various operations:

- `-cs`, `--containerscan`: Initiate a container scan.
- `-cr`, `--customrules`: Fetch custom rules.
- `-c`, `--console`: Console hostname (mandatory).
- `-v`, `--version`: API version (default `31.02`).
- `-ucc`, `--updatecustomcompliance`: Update custom compliance rules from a file.

### 📝 Example Commands

```bash
python script.py -cs -c [console_hostname] -v 31.02
python script.py -ucc [custom_compliance.json] -c [console_hostname]
```

## 📂 Repository Directories

- **Scripts Directory**: Find the Python script and other utility scripts in our [Scripts Directory](https://github.com/jcspigler2010/STIGTOShell/tree/main/scripts).
- **Apache Server 2.4 (UNIX Server) Policies**: Explore the custom compliance checks for Apache Server 2.4 on UNIX in the [Apache Server Directory](https://github.com/jcspigler2010/STIGTOShell/tree/main/apache_server_2.4_unix_server).

## 🛠 Getting Started

1. **Clone the Repository**: 
   ```bash
   git clone https://github.com/jcspigler2010/STIGTOShell.git
   ```
   
2. **Install Dependencies** (if required):
   ```bash
   pip install -r requirements.txt
   ```

## 🤝 Contributing

We welcome contributions! Feel free to improve existing scripts or add new ones.

## 📄 License

OpenSource use at your own risk


# STIGFusion-PrismaVigil

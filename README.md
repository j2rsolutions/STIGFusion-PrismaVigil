# STIG FUSION PRISMA VIGIL

![DISA STIG](/images/disa_stig.png)   ![Prisma Cloud](/images/prisma_cloud.png)

## Overview
STIGFUSION-PRISMAVIGIL strives to be a comprehensive collection of Prisma Cloud Compute custom compliance checks and runtime rules designed to support development efforts in meeting DISA STIG requirements. This project is dedicated to identifying and addressing runtime deviations and potential security anomalies within development environments.

## Focus Areas

### Adherence to STIG Norms with Enhanced Focus
We ensure strict adherence to STIG standards, targeting configurations that, if altered, could become points of exploitation. This extends beyond compliance, as we utilize Prisma Cloud Compute's capabilities to transform these guidelines into a proactive defense mechanism against potential security breaches.

### Collaborative Development for Dynamic Compliance
Our strategy involves a transparent and collaborative development process. Utilizing a dedicated Git repository, we update and refine runtime rules, clearly linking each modification to specific STIG findings. This fosters teamwork and ensures a comprehensive understanding and application of STIG standards in our security practices.

### Targeted Monitoring for Advanced Threat Protection
Recognizing the evolving nature of APTs, our approach includes focused monitoring of 'areas of interest,' as highlighted by STIG. We proactively surveil these critical zones, equipping ourselves to detect and respond to deviations that might signal an advanced threat. This targeted monitoring, empowered by Prisma Cloud Compute, ensures active defense against sophisticated APT tactics.


## Project Structure
The project is organized into the following primary directories at the root level:

- `scripts`: Contains scripts for Prisma Cloud API interaction and utility functions.
- `stigs`: Contains subdirectories for specific STIGs, with custom compliance checks and runtime rules.
- `Documentation`: Contains additional documentation resources, including detailed development flows and diagrams.

### Documentation Directory
The `Documentation` directory provides more detailed information on various aspects of the project. This includes in-depth guides, flow diagrams, and other resources to assist with the understanding and usage of the project.

- [`Custom Runtime Rule Development Flow`](./Documentation/customRuntimeRuleDevelopmentFlow/README.md): Contains documentation specific to the development workflow, including the `PrismaVigilFlow.jpg` diagram that illustrates the development process.

### STIGs Directory
Each subdirectory within `stigs` is dedicated to a particular STIG and includes:

- `custom_compliance_checks`: Mapped directly to DISA STIG rules to ensure compliance.
- `custom_runtime_rules`: Designed to detect runtime events, providing insights into compliance adherence.

## Python Script for Prisma Cloud API Interaction
The Python script is an essential tool for interacting with the Prisma Cloud API, enabling the automation of compliance and runtime rule management. The script includes the following capabilities:

## Collaborative Development for Dynamic Compliance
In our pursuit of dynamic compliance with STIG standards, we recognize the need for a structured yet adaptable development process. This approach is critical in environments where a prescriptive method may not always be applicable.

### Procedure and Pipeline Development
- **Intuitive Workflow Integration:** Our development workflow integrates seamlessly into the routines of our development teams, ensuring efficiency and minimal disruption.
- **Iterative Development Cycle:** An iterative approach allows for continuous improvement in security measures and compliance practices.
- **Clear Documentation and Guidelines:** Comprehensive documentation and guidelines are provided to ensure all team members are aligned with the project's objectives and the nuances of STIG standards.
- **Collaboration-Focused Tools:** Tools such as Git repositories are employed to enhance collaboration, allowing for transparent tracking of changes and collective problem-solving.
- **Feedback Loops and Quality Assurance:** Feedback mechanisms and quality assurance processes are embedded within our pipeline to uphold high standards for security and compliance.
- **Linking Changes to STIG Findings:** Each modification in our security posture is explicitly linked to specific STIG findings, ensuring clarity and traceability.

Our goal is to embed compliance within our development practices, maintaining agility and innovation while securing our systems.

## Getting Started
To use STIGFUSION-PRISMAVIGIL, clone the repository and navigate through the `scripts` and `stigs` directories. The Python script can be used for efficient interaction with the Prisma Cloud environment, as well as for converting raw rule definitions into a structured format suitable for import.

## Contributing
We encourage contributions that align with the project's goal of supporting development efforts in compliance and security. Please follow the established naming conventions and provide thorough documentation for your contributions.

## License
Opensource use at own risk

*Supporting development efforts in compliance and security monitoring within Prisma Cloud Compute environments.*

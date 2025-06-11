# Ansible macOS Setup

An Ansible-based automation tool for setting up and configuring macOS environments.

## Overview

This project uses Ansible to automate the setup and configuration of a macOS environment. It currently focuses on installing and managing Homebrew packages, specifically the `aerospace` package.

## Features

- Automated Homebrew installation
- Package management via Ansible roles
- Easy setup with a single bootstrap script
- Rollback capability to undo changes

## Prerequisites

- macOS (tested on macOS Monterey and newer)
- Internet connection
- Admin privileges (for some operations)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/ansible-macos-setup.git
   cd ansible-macos-setup
   ```

2. Run the bootstrap script:
   ```bash
   ./bootstrap.sh
   ```

   This script will:
   - Install Homebrew if not already installed
   - Install Ansible via Homebrew
   - Run the Ansible playbook to configure your system

## Structure

```
.
├── bootstrap.sh          # Initial setup script
├── inventory             # Ansible inventory file
├── playbook.yml          # Main Ansible playbook
├── README.md             # This documentation
├── rollback.sh           # Script to undo changes
└── roles/                # Ansible roles
    └── homebrew/         # Role for managing Homebrew packages
        ├── defaults/     # Default variables
        │   └── main.yml  # Package list
        └── tasks/        # Tasks for the role
            └── main.yml  # Main tasks file
```

## Customization

To customize the packages installed:

1. Edit `roles/homebrew/defaults/main.yml` to modify the list of packages.
2. Run the playbook again:
   ```bash
   ansible-playbook -i inventory playbook.yml --ask-become-pass
   ```

## Rollback

If you need to undo the changes made by this setup:

```bash
./rollback.sh
```

This will remove the packages installed by the playbook.

## License

See the [LICENSE](LICENSE) file for details.

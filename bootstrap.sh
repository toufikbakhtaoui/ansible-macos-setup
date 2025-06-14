#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo -e "${GREEN}=== Starting Automated Setup ===${NC}"

# Fail function with colored output
fail() {
    echo -e "${RED}Error: $1${NC}"
    exit 1
}

# Step 0: Install Xcode Command Line Tools
echo -e "${GREEN}✓ Checking Xcode CLI Tools${NC}"
if ! xcode-select -p &>/dev/null; then
    echo -e "${YELLOW}→ Installing Xcode CLI Tools (may take several minutes)${NC}"
    xcode-select --install || fail "Failed to install Xcode CLI Tools"
    # Wait for installation to complete
    while ! xcode-select -p &>/dev/null; do
        sleep 5
    done
    sudo xcodebuild -license accept
fi

# Step 1: Install Homebrew if missing
echo -e "${GREEN}✓ Checking Homebrew${NC}"
if ! command -v brew &>/dev/null; then
    echo -e "${YELLOW}→ Installing Homebrew${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || fail "Failed to install Homebrew"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Step 2: Install Git and Ansible via Homebrew
echo -e "${GREEN}✓ Installing required tools${NC}"
brew install git ansible || fail "Failed to install required tools"

# Step 3: Clone configuration repo
echo -e "${GREEN}✓ Downloading configuration${NC}"
if [ -d "ansible-macos-setup" ]; then
    echo -e "${YELLOW}→ Updating existing repository${NC}"
    cd ansible-macos-setup && git pull && cd .. || fail "Failed to update repository"
else
    git clone git@github.com:toufikbakhtaoui/ansible-macos-setup.git || fail "Failed to clone repository"
fi

# Step 4: Execute Ansible playbook
echo -e "${GREEN}✓ Running final configuration${NC}"
cd ansible-macos-setup && ansible-playbook playbook.yml || fail "Ansible playbook failed"

echo -e "${GREEN}=== Setup completed successfully! ===${NC}"
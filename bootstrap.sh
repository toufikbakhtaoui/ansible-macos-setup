#!/bin/bash
set -e

# Colors for better output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print status messages
print_status() {
  echo -e "${GREEN}$1${NC}"
}

# Function to print warning messages
print_warning() {
  echo -e "${YELLOW}$1${NC}"
}

# Function to print error messages
print_error() {
  echo -e "${RED}$1${NC}"
}

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

print_status "🔧 Checking prerequisites..."

# Check if Xcode Command Line Tools are installed
if ! command_exists xcode-select; then
  print_warning "Installing Xcode Command Line Tools..."
  xcode-select --install || {
    print_error "Failed to install Xcode Command Line Tools"
    exit 1
  }
fi

print_status "🔧 Installing Homebrew if not present..."

if ! command_exists brew; then
  print_warning "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
    print_error "Failed to install Homebrew"
    exit 1
  }
  
  # Add Homebrew to PATH if needed
  if [[ $(uname -m) == "arm64" ]]; then
    # For Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
      print_status "Added Homebrew to PATH for Apple Silicon Mac"
    fi
  else
    # For Intel Macs
    if [[ -f "/usr/local/bin/brew" ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
      print_status "Added Homebrew to PATH for Intel Mac"
    fi
  fi
else
  print_status "Homebrew is already installed"
fi

print_status "📦 Installing Ansible..."
brew install ansible || {
  print_error "Failed to install Ansible"
  exit 1
}

print_status "🚀 Running Ansible playbook..."
ansible-playbook -i inventory playbook.yml --ask-become-pass || {
  print_error "Ansible playbook execution failed"
  exit 1
}

print_status "✅ Setup completed successfully!"

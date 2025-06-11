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

# Check if Homebrew is installed
if ! command_exists brew; then
  print_error "Homebrew is not installed. Nothing to rollback."
  exit 1
fi

print_warning "⚠️  WARNING: This will remove the package 'aerospace' installed by this setup."
read -p "Are you sure you want to proceed? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  print_status "Rollback cancelled."
  exit 0
fi

print_status "🔄 Rolling back..."

# Remove specific packages installed by our playbook
if brew list aerospace &>/dev/null; then
  print_status "Removing aerospace package..."
  brew remove aerospace || {
    print_error "Failed to remove aerospace package"
    exit 1
  }
else
  print_warning "Package aerospace is not installed"
fi

# Cleanup Homebrew
print_status "Cleaning up Homebrew..."
brew cleanup || {
  print_error "Failed to clean up Homebrew"
  exit 1
}

print_status "✅ Rollback completed successfully!"

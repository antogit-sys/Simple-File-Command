#!/bin/bash

# Script to install required dependencies for the Simple-File project

# Main function
main() {
    # Get the package manager of the distribution
    PM=$(get_package_manager)

    # Check if the distribution is supported
    if [ "$PM" == "unknown" ]; then
        echo "Unsupported distribution. Please install dependencies manually."
        exit 1
    fi

    # Update and upgrade packages
    update_and_upgrade_packages

    # Install dependencies
    install_dependencies

    # Conclusion
    echo "Dependencies installation complete."
    sleep 2
    echo "install Simple-File (sfile) ..."
    make install
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to identify the package manager
get_package_manager() {
    if command_exists apt; then
        echo "apt"  # Debian/Ubuntu-based
    elif command_exists dnf; then
        echo "dnf"  # Fedora/RHEL 8+
    elif command_exists yum; then
        echo "yum"  # RHEL 7/8, CentOS 7/8, and older
    elif command_exists pacman; then
        echo "pacman"  # Arch Linux / Manjaro
    else
        echo "unknown"  # Package manager not recognized
    fi
}

# Update and upgrade packages
update_and_upgrade_packages() {
    echo "Updating and upgrading packages..."

    if [ "$PM" == "apt" ]; then
        sudo apt update && sudo apt upgrade -y
    elif [ "$PM" == "dnf" ]; then
        sudo dnf check-update && sudo dnf upgrade -y
    elif [ "$PM" == "yum" ]; then
        sudo yum check-update && sudo yum upgrade -y
    elif [ "$PM" == "pacman" ]; then
        sudo pacman -Sy && sudo pacman -Syu --noconfirm
    fi
}

# Function to install libmagic-dev (or equivalent package)
install_libmagic() {
    if [ "$PM" == "apt" ]; then
        sudo apt install -y libmagic-dev
    elif [ "$PM" == "dnf" ]; then
        sudo dnf install -y libmagic-devel
    elif [ "$PM" == "yum" ]; then
        sudo yum install -y libmagic-devel
    elif [ "$PM" == "pacman" ]; then
        sudo pacman -S --noconfirm libmagic
    fi
}

# Function to install gcc
install_gcc() {
    if [ "$PM" == "apt" ]; then
        sudo apt install -y gcc
    elif [ "$PM" == "dnf" ]; then
        sudo dnf install -y gcc
    elif [ "$PM" == "yum" ]; then
        sudo yum install -y gcc
    elif [ "$PM" == "pacman" ]; then
        sudo pacman -S --noconfirm gcc
    fi
}

# Function to install make
install_make() {
    if [ "$PM" == "apt" ]; then
        sudo apt install -y make
    elif [ "$PM" == "dnf" ]; then
        sudo dnf install -y make
    elif [ "$PM" == "yum" ]; then
        sudo yum install -y make
    elif [ "$PM" == "pacman" ]; then
        sudo pacman -S --noconfirm make
    fi
}

# Function to check if libmagic is installed
check_libmagic() {
    if [ "$PM" == "apt" ]; then
        dpkg -l | grep -q "libmagic-dev"
    elif [ "$PM" == "dnf" ]; then
        rpm -q libmagic-devel
    elif [ "$PM" == "yum" ]; then
        rpm -q libmagic-devel
    elif [ "$PM" == "pacman" ]; then
        pacman -Q libmagic
    fi
}

# Function to install dependencies
install_dependencies() {
    # Install libmagic if not installed
    echo "Checking if libmagic is installed..."
    if check_libmagic; then
        echo "libmagic is already installed."
    else
        echo "libmagic is not installed. Installing..."
        install_libmagic
    fi

    # Install gcc if not installed
    if ! command_exists gcc; then
        echo "gcc is not installed. Installing gcc..."
        install_gcc
    else
        echo "gcc is already installed."
    fi

    # Install make if not installed
    if ! command_exists make; then
        echo "make is not installed. Installing make..."
        install_make
    else
        echo "make is already installed."
    fi
}

# Run the main function
main

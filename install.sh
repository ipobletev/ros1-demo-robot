#!/bin/bash

# Function to check the status of the last executed command
check_status() {
    if [ $? -ne 0 ]; then
        echo "ERROR: $1 failed. Exiting script."
        exit 1
    else
        echo "SUCCESS: $1 completed."
    fi
}

# Check if the script is run with root privileges (sudo)
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run with sudo or as root."
    echo "Please run: sudo ./install.sh"
    exit 1
fi

echo "----------------------------------------------------"
echo "Starting system setup and ROS Noetic installation."
echo "This process may take some time. Please be patient."
echo "----------------------------------------------------"

# Section 1: System Update
echo ""
echo "--- Section 1: System Update and Core Tools ---"
echo "Updating package lists and upgrading installed packages..."
sudo apt-get update && sudo apt upgrade -y
sudo apt-get install git -y
sudo apt-get install git-lfs -y

# Section 2: ROS Noetic Setup
echo ""
echo "--- Section 2: ROS Noetic Setup ---"
echo "Adding ROS Noetic repository to your system sources..."
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

echo "Installing curl to fetch ROS key..."
sudo apt install -y curl

echo "Adding ROS public key..."
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

echo "Updating package lists after adding ROS repository..."
sudo apt update

echo "Installing ROS Noetic Desktop Full"
sudo apt install -y ros-noetic-desktop-full

echo "Setting up ROS environment by adding source command to ~/.bashrc..."
echo -e "\n# ROS\nsource /opt/ros/noetic/setup.bash" >> ~/.bashrc
echo "Sourcing ~/.bashrc to apply changes immediately"
source ~/.bashrc

# Section 3: ROS Additional Tools and Dependencies
echo ""
echo "--- Section 3: ROS Additional Tools and Dependencies ---"
echo "Installing additional ROS tools and build essential packages..."
sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

echo "Initializing and updating rosdep..."
sudo rosdep init
rosdep update

echo "Installing ROS dependencies from 'src' directory using rosdep..."
echo "Note: This step assumes you have a 'src' directory with ROS packages in the current path."
rosdep install --from-paths src -r -y

# Section 4: Python Requirements
echo ""
echo "--- Section 4: Python Requirements ---"
echo "Installing python3-pip..."
sudo apt install python3-pip -y

# Section 5: Ros Packages Requirements
sudo apt-get install ros-noetic-rospy -y
sudo apt-get install ros-noetic-robot-state-publisher -y
sudo apt-get install ros-noetic-teleop-twist-keyboard -y
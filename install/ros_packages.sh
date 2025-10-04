echo "----------------------------------------------------"
echo "Starting installation of ROS packages."
echo "This process may take some time. Please be patient."
echo "----------------------------------------------------"
# Ros Packages Requirements
sudo apt install liburdfdom-tools
sudo apt-get install ros-noetic-rospy -y
sudo apt-get install ros-noetic-robot-state-publisher -y
sudo apt-get install ros-noetic-teleop-twist-keyboard -y
sudo apt-get install ros-noetic-ros-control ros-noetic-ros-controllers ros-noetic-gazebo-ros-control -y
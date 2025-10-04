# Demo Robot Ros1

### 1.- Install requirements
#### 1.1- Before Install
    sudo apt-get update 
    sudo apt upgrade -y
    sudo apt install git git-lfs terminator -y &
    sudo snap install code --classic

#### 1.3- Clone Repo and Install 
    sudo chmod +x install/ros_noetic.sh
    sudo ./install/ros_noetic.sh
---
### 2.- Compilation and source

    source /opt/ros/noetic/setup.bash && catkin_make && source devel/setup.bash
    
### 3.- Execute

#### Simulate RViz
    roslaunch robot_a_description rviz.launch

#### Simulate Gazebo

Start Gazebo
    
    roslaunch gazebo_ros empty_world.launch

Spawn robot in Gazebo
    
    roslaunch robot_a_description spawn.launch

Other option: Gazebo + Spawn Robot

    roslaunch robot_a_description gazebo.launch

#### Teleoperate
    rosrun teleop_twist_keyboard teleop_twist_keyboard.py /cmd_vel:=/part2_cmr/cmd_vel

#### Carga manual de urdf a /robot_a_description

    rosparam set robot_a_description "$(xacro $(rospack find robot_a_description)/urdf/robot.xacro)"

#### Visualize TF Tree

    rosrun rqt_tf_tree rqt_tf_tree
#!/bin/bash

set +H
username=$1

## instal tools
which xdotool || sudo apt install xdotool -y
which wmctrl || sudo apt install wmctrl -y

# Prompt for password (hidden input)
read -s -p "Enter mail base password: " mail_password

# Desired window size
width=1200
height=915

# Start Chrome  window
google-chrome &
# Wait for the window to open
sleep 2
# Get the window ID of the Chrome window
window_id=$(xdotool search --class "google-chrome" | tail -1)
# Activate/focus the Chrome window
xdotool windowactivate --sync "$window_id"

sleep 0.5
#https://askubuntu.com/questions/1386017/xdotool-windowsize-and-windowmove-dont-work-in-gnome-when-the-window-is-ful
#Remove the maximized_vert and maximized_horz using wmctrl first before manipulating it further with xdotool.
wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz 
xdotool windowsize "$window_id" "$width" "$height" 
xdotool getwindowfocus windowmove 0 0

# exit
sleep 1


#### log out incase logged in
xdotool getactivewindow key ctrl+t
# Send keystrokes using xdotool
xdotool type "mail.cseco.co.ke"
# Send Enter key using xdotool
xdotool key Return
sleep 2
#### log out incase logged in
xdotool mousemove 1144 156
sleep 0.5
# RIGHT Click at the current mouse position
xdotool click 1
sleep 3 ## wait for logout

# Send CTRL+T using xdotool
# xdotool keydown Control key T
# sleep 0.1
# xdotool keyup Control key T
xdotool getactivewindow key ctrl+t

# Send keystrokes using xdotool
xdotool type "admin.google.com"
# Send Enter key using xdotool
xdotool key Return
# Pause for 5 seconds
sleep 5


#### ignore since we will be already signed in
# for ((i = 0; i < ${#username}; i++)); do
#   character="${username:i:1}"
#   xdotool type "$character"
#   sleep 0.01
# done
# xdotool key Return
# sleep 5
# # xdotool type "$password"
# for ((i = 0; i < ${#password}; i++)); do
#   character="${password:i:1}"
#   xdotool type "$character"
#   # echo $character
#   # xdotool type "$character"
#   sleep 0.01
# done
# xdotool key Return

# sleep 15

# Move mouse pointer to position (x, y)
#####
##### confirm position
#####
#exit
xdotool mousemove 336 280
sleep 1
# Click at the current mouse position
xdotool click 1

sleep 5
#exit





emailFile="./accounts"
# add blank line to end of file
# Read each line (email) from the file
# counter=0
while IFS= read -r email
do
  # ((counter++))
  if grep -Fxq "$email" "./sentInvites"; then
    echo "Email '$email' already sent. Skipping."
    continue
  fi
  # Extract the numerical index
  index="${email%%@*}"  # Remove everything after '@' symbol
  index="${index//[!0-9]/}"  # Remove non-digit characters
  #####
  ##### confirm position
  #####
  #exit
  #### open dialog
  xdotool mousemove 782 303
  sleep 0.1
  # Click at the current mouse position
  xdotool click 1
  sleep  2 # wait for dialog to open

  ## clear all
  # Send Backspace using xdotool
  xdotool getactivewindow key ctrl+a
  sleep 0.01
  xdotool getactivewindow key BackSpace
  sleep 0.01
  
  for ((i = 0; i < ${#email}; i++)); do
    character="${email:i:1}"
    xdotool type "$character"
    sleep 0.01
  done
  xdotool key Return
  ## wait for invite to be sent
  sleep 2
  echo "$email" >> ./sentInvites


### since email does not arrive instantly, we will have to send out all the invites first
 
  # xdotool getactivewindow key ctrl+Tab

done < "$emailFile"





#  sleep 2
#   ## open our mail in new tab
#   xdotool getactivewindow key ctrl+t
#   # Send keystrokes using xdotool
#   xdotool type "mail.cseco.co.ke"
#   # Send Enter key using xdotool
#   xdotool key Return
#   sleep 2

#   xdotool type "$email"
#   xdotool key Return
#   xdotool type "$mail_password$index"
#   xdotool key Return

#   sleep 3
  
#   # Move mouse pointer to position (x, y)
#   #####
#   ##### confirm position
#   #####
#   # exit
#   xdotool mousemove 357 342
#   sleep 0.5
#   # RIGHT Click at the current mouse position
#   xdotool click 3
#   sleep 0.5


#   xdotool type "t"
#   sleep 2
#   xdotool getactivewindow key ctrl+Tab

#   #####
#   ##### confirm position
#   #####
#   # exit
#   xdotool mousemove 550 838
#   sleep 0.5
#   xdotool click 1
#   sleep 3


#   ## fill in form
#   # wait for captcha to be solved
#   sleep 2
#   #click the first input
#   xdotool mousemove 441 293
#   sleep 0.5
#   xdotool click 1
#   sleep 0.5

#   name=$(sed -n "${index}p" "./names.txt")
#   read -r first_name last_name <<< "$nth_line"
#   for ((i = 0; i < ${#first_name}; i++)); do
#     character="${first_name:i:1}"
#     xdotool type "$character"
#     sleep 0.01
#   done
#   xdotool key Tab
#   sleep 0.01

#   tmpPass="$mail_password$counter"
#   for ((i = 0; i < ${#last_name}; i++)); do
#     character="${last_name:i:1}"
#     xdotool type "$character"
#     sleep 0.01
#   done
#   xdotool key Tab
#   sleep 0.01
#   tmpPass="$mail_password$index"
#   for ((i = 0; i < ${#tmpPass}; i++)); do
#     character="${tmpPass:i:1}"
#     xdotool type "$character"
#     sleep 0.01
#   done
#   xdotool key Tab
#   sleep 0.01
#   xdotool key Tab
#   sleep 0.01
#   xdotool key Tab
#   sleep 0.01
#   xdotool key Tab
#   sleep 0.01
#   xdotool key Return
#   break

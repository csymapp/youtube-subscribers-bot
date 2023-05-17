#!/bin/bash
#### copy links sent
####
set +H
# username=$1

## instal tools
which xdotool || sudo apt install xdotool -y
which wmctrl || sudo apt install wmctrl -y
which xclip || sudo apt install xclip -y

# Prompt for password (hidden input)
read -s -p "Enter mail base password: " mail_password

# Desired window size
width=1200
height=915

logout(){
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
sleep 1 ## wait for logout
}

startChrome(){
# Start Chrome  window
killall chrome
# google-chrome &
google-chrome --incognito & # allow captcha clicker in incognito
# Wait for the window to open
sleep 1
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
sleep 0.5


logout
}
startChrome

# # Send CTRL+T using xdotool
# # xdotool keydown Control key T
# # sleep 0.1
# # xdotool keyup Control key T
# xdotool getactivewindow key ctrl+t

# # Send keystrokes using xdotool
# xdotool type "admin.google.com"
# # Send Enter key using xdotool
# xdotool key Return
# # Pause for 5 seconds
# sleep 5


######## try every link
######## assume none has worked
######## if no link in emails, assume not yet created
######## 

echo "" >> ./missingEmails
echo "" >> ./createdAccounts
emailFile="./sentInvites"
while IFS= read -r email
do
  # ((counter++))
  if grep -Fxq "$email" "./createdAccounts"; then
    echo "Email '$email' already sent. Skipping."
    continue
  fi
  # Extract the numerical index
  index="${email%%@*}"  # Remove everything after '@' symbol
  index="${index//[!0-9]/}"  # Remove non-digit characters
  
logout
    xdotool getactivewindow key ctrl+w
    sleep 0.1
  ## open our mail in new tab
  xdotool getactivewindow key ctrl+t
  # Send keystrokes using xdotool
  xdotool type "mail.cseco.co.ke"
  # Send Enter key using xdotool
  xdotool key Return
  sleep 2

  xdotool type "$email"
  xdotool key Return
  xdotool type "$mail_password$index"
  xdotool key Return

  sleep 3


  # Set the output file path
output_file="output.txt"

xdotool key --clearmodifiers ctrl+a
xdotool key --clearmodifiers ctrl+c
# Wait for a moment to ensure the text is copied
sleep 1
# Retrieve the copied text from the clipboard
copied_text=$(xclip -selection clipboard -o 2>/dev/null)
# Save the copied text to the output file
echo "$copied_text" > "$output_file"

#### check if "The Google Workspace Team" is in text to confirm that invite was sent to account
##### this should work because we are doig the check before several emails are sent to the email we are checking
# Search for the specified string in the file
if grep -q "The Google Workspace Team" "$output_file"; then
  echo "The string 'The Google Workspace Team' was found in the file."
  # Use sed to remove the matching line from the file
    sed -i "/$email/d" "./missingEmails"

    # Check if the line was successfully removed
    # if [ $? -eq 0 ]; then
    # echo "The line '$email' was removed from the file."
    # else
    # echo "Failed to remove the line '$email' from the file."
    # fi
    else
    echo "$email" >> ./missingEmails
    continue
fi



  # Move mouse pointer to position (x, y)
  #####
  ##### confirm position
  #####
  # exit
  xdotool mousemove 357 342
  sleep 0.5
  # RIGHT Click at the current mouse position
  xdotool click 3
  sleep 0.5

  
  ### open last mail in new tab
  xdotool type "t"
  sleep 0.01
  ## since there is a CTRL+A, it does not work alone, but we also have to add Enter
  xdotool key Return
  sleep 0.1
  xdotool getactivewindow key ctrl+Tab
sleep 2
#   #####
#   ##### confirm position
#   #####
#   # exit
####
### open link in new tab
###
  xdotool mousemove 550 838
  sleep 0.5
  xdotool click 3
  sleep 0.1
  xdotool type "t"
  sleep 3
  ### switch to account creation tab
    xdotool key ctrl+Tab
  sleep 0.5

  xdotool key ctrl+l
  sleep 0.1  #

xdotool key --clearmodifiers ctrl+c
# Wait for a moment to ensure the text is copied
sleep 1
# Retrieve the copied text from the clipboard
copied_text=$(xclip -selection clipboard -o 2>/dev/null)
# Save the copied text to the output file
echo "$copied_text" >> "./link"

xdotool getactivewindow key ctrl+w
  sleep 0.5
  xdotool getactivewindow key ctrl+w
    sleep 0.5
    xdotool getactivewindow key ctrl+w
    sleep 0.5


done < "$emailFile"



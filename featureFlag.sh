clear
red="\e[1;91m"
green="\e[1;92m"
white="\e[0m"
file="/vendor/build.prop"
sudo="su -c"
su -v &> /dev/null
if [ $? -ne 0 ]; then
  echo -e "${red}Root Permission Unavailable${white}"
  exit
fi
### Setting Permission & Mounting ###
sudo mount -o remount,rw /vendor
### Backing UP ###
sudo [ -e $file.backup ] && echo -e "${red}---> Wew Backup Exist${white}" || sudo cp $file $file.backup && echo -e "${green}---> $file Backup Completed${white}"
### Checking ON of OFF ###
sudo cat $file | grep "persist.sys.fflag.override.settings_fuse=true" &> /dev/null
if [ $? -ne 0 ]; then
  echo -e "persist.sys.fflag.override.settings_fuse=${red}false${white}"
else
  echo -e "persist.sys.fflag.override.settings_fuse=${green}true${white}"
fi
### Toggle Command ###
read -n1 -p $"Press 1 to toggle or Press 0 to exit: " input
if [ $input -eq 1 ]; then
echo -e "${red}Default Last Line"
sudo tail -1 $file
echo -e "${white}"
### Writing lines to /vendor/build.prop ####
sudo echo "persist.sys.fflag.override.settings_fuse=true" | sudo tee -a $file > /dev/null
echo -e "\n${green}Last line after changes"
sudo tail -1 $file
echo -e "${white}"
fi
### Default Permission & Unmounting ####
sudo mount -o remount,ro /vendor 
echo

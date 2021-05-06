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

sudo mount -o remount,rw /vendor
### Backing UP ###
if [ -e "$file.backup" ]; then
  echo -e "${red}---> Backup Exist${white}"
else
  sudo cp $file $file.backup
  echo -e "${green}---> $file Backup Completed${white}"
fi
sudo cat $file | grep "persist.sys.fflag.override.settings_fuse=true" &> /dev/null
if [ $? -ne 0 ]; then
  echo -e "persist.sys.fflag.override.settings_fuse=${red}false${white}"
else
  echo -e "persist.sys.fflag.override.settings_fuse=${green}true${white}"
fi
read -n1 -p $"Press 1 to toggle or Press 0 to exit" input
if [ $input -eq 1 ]; then
echo -e "${red}"
sudo cat $file
echo -e "${white}"
sudo echo "persist.sys.fflag.override.settings_fuse=true" >> $file
echo -e "\n${green}"
sudo cat $file
echo -e "${white}"
fi
sudo mount -o remount,ro /vendor
  

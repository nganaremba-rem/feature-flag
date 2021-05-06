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

sudo mount -o remount,rw /
echo -e "${red}"
sudo cat $file
echo -e "${white}"
sudo echo "persist.sys.fflag.override.settings_fuse=true" >> $file
echo -e "\n${green}"
sudo cat $file
echo -e "${white}"

sudo mount -o remount,ro /
  

clear
red="\e[1;91m"
green="\e[1;92m"
white="\e[0m"
file="/vendor/build.prop"
su -v &> /dev/null
if [ $? -ne 0 ]; then
  echo -e "${red}Root Permission Unavailable${white}"
  exit
fi
echo -e "${red}"
cat $file
echo -e "${white}"
su -c mount -o remount,rw /
echo "persist.sys.fflag.override.settings_fuse=true" >> $file
su -c mount -o remount,ro /
echo -e "\n${green}"
cat $file
echo -e "${white}"

  

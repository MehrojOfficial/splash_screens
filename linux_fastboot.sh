cd "`dirname "$0"`"
echo ""
fastboot=bin/linux/fastboot
[ ! -f $fastboot ] && echo "$fastboot not found." && read -p "Press any key to close ..." && exit 1
[ ! -x $fastboot ] && echo "$fastboot cannot be executed." && read -p "Press any key to close ..." && exit 1
echo "Waiting for device... (Install drivers if needed)"
device=`$fastboot getvar product 2>&1 | grep -F 'product:' | tr -s ' ' | cut -d ' ' -f 2`
status='false'
[ -z "$device" ] && device='unknown'

[ "$device" == 'secret' ] && status='true'
[ "$device" == 'rosemary' ] && status='true'
[ "$device" == 'maltose' ] && status='true'

[ "$status" != 'true' ] && echo "Compatible devices: rosemary/secret/maltose" && echo "Your device: $device" && echo "[Missmatching image and device]" && read -p "Press any key to close ..." && exit 1

echo "Your device: $device"
echo "Edition: MI"
echo ""
echo "This script will flash modified logo to this device."
echo ""
$fastboot flash logo logo.bin
if [ $? -ne 0 ] ; then echo "flash logo error"; sleep infinity; fi
echo ""
$fastboot reboot
echo ""
echo "##################################################################################"
echo "MI Logo is flashed succesfully. Follow @byMehroj on Telegram for more ..."
echo "##################################################################################"
echo ""
read -p "Press any key to close ..." && exit 1

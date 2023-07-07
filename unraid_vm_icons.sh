# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #  Download custom vm icons from github and add them to Unraid server # #
# #  by - SpaceinvaderOne                                               # #
# #  customized by - LeftyJohnaon                                       # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Directory for downloaded icons to be stored
DIR="/mnt/user/appdata/vm_custom_icons/icons"

# Delete icon store if present
delete="yes"

# Keep stock Unraid VM icons
stock="yes"

# Download windows based OS icons
windows="yes"

# Download linux based OS icons
linux="yes"

# Download freebsd based OS icons
freebsd="yes"

# Download macOS based OS icons
macos="yes"

# Download other OS icons
other="yes"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #  Functions                                                          # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Delete icon store if present and delete set to yes
shall_i_delete() {
	#check if icon store exists and delete it if clear icons flag is set
	if [ -d $DIR ] && [ $delete == "yes" ]; then

	rm -r $DIR
	echo "I have deleted all vm icons ready to download fresh icons to sync"
    echo "."
    echo "."
else
	#do nothing and continue of clear icons flag is not set
	echo "  Clear all icons not set......continuing."

	fi

}

checkgit() {

	# delete directory if previously run so can do fresh gitclone
	if [ -d /mnt/user/appdata/vm_custom_icons/unraid_vm_icons ] ; then
    rm -r /mnt/user/appdata/vm_custom_icons/unraid_vm_icons
    fi
	#run gitclone
git -C /mnt/user/appdata/vm_custom_icons clone https://github.com/SpaceinvaderOne/unraid_vm_icons.git
}

# Create icon directory if not present then download selected icons. Skip if already done
downloadicons() {
	if [ ! -d $DIR ] ; then

	mkdir -vp $DIR
	echo "I have created the icon store directory & now will start downloading selected icons"
    checkgit
	downloadstock
	downloadwindows
	downloadlinux
	downloadfreebsd
	downloadother
	downloadmacos
    echo "."
    echo "."
	echo "icons downloaded"
else

    echo "."
    echo "."
	echo "Icons downloaded previously."


	fi

}

# Sync icons in icon store to vm manager
syncicons() {
	#make sure at least one file exists before trying to delete
	touch /usr/local/emhttp/plugins/dynamix.vm.manager/templates/images/windowsxp.png
	#delete all existing icons in vm manager
	rm /usr/local/emhttp/plugins/dynamix.vm.manager/templates/images/*
	#sync all icons selected to vm manager
	rsync -a $DIR/ /usr/local/emhttp/plugins/dynamix.vm.manager/templates/images/
	#reset permissions of appdata folder
	chmod 777 -R /mnt/user/appdata/vm_custom_icons/
	#print message
    echo "icons synced"
}

# Keep stock Unraid VM icons if set
downloadstock() {
    if [ $stock == "yes" ] ; then
	rsync -a /mnt/user/appdata/vm_custom_icons/unraid_vm_icons/icons/Stock_Icons/ $DIR/
			else
				echo "  unraid stock icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# Download windows based OS icons if set
downloadwindows() {
    if [ $windows == "yes" ] ; then
	rsync -a /mnt/user/appdata/vm_custom_icons/unraid_vm_icons/icons/Windows/ $DIR/
			else
				echo "  windows based os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# Download linux based OS icons if set
downloadlinux() {
    if [ $linux == "yes" ] ; then
    rsync -a /mnt/user/appdata/vm_custom_icons/unraid_vm_icons/icons/Linux/ $DIR/
			else
				echo "  linux based os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}


# Download freebsd based OS icons if set
downloadfreebsd() {
    if [ $freebsd == "yes" ] ; then
	rsync -a /mnt/user/appdata/vm_custom_icons/unraid_vm_icons/icons/Freebsd/ $DIR/
			else
				echo "  freebsd based os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# Download other OS icons if set
downloadother() {
    if [ $other == "yes" ] ; then
	rsync -a /mnt/user/appdata/vm_custom_icons/unraid_vm_icons/icons/Other/ $DIR/
			else
				echo "  other os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# Download macOS based OS icons if set
downloadmacos() {
    if [ $macos == "yes" ] ; then
	rsync -a /mnt/user/appdata/vm_custom_icons/unraid_vm_icons/icons/macOS/ $DIR/
			else
				echo "  macos based os icons not wanted......continuing."
			    echo "."
			    echo "."


fi
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #  run functions                                                      # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

shall_i_delete
downloadicons
syncicons

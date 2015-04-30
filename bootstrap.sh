GIT_USER=`git config --global --get user.name`
if [ -z "${GIT_USER}" ]; then
	echo -n "Please enter your git user.name: "
	read GIT_USER
	git config --global user.name "${GIT_USER}"
fi

GIT_EMAIL=`git config --global --get user.email`
if [ -z "${GIT_EMAIL}" ]; then
	echo -n "Please enter your git user.email: "
	read GIT_EMAIL
	git config --global user.email "${GIT_EMAIL}"
fi

echo
echo
echo "Intalling boxen in /opt"
if [ ! -d "/opt" ]; then
	sudo mkdir /opt
fi
if [ ! -f "/opt/boxex/bootstrap.sh" ]; then
	echo "Creating link in /opt"
	sudo ln -s $HOME/my-boxen /opt/boxen
	sudo chown -R $USER  /opt/boxen
fi

echo
echo
XCODE_PATH=`xcode-select -p`
if [ -z "${XCODE_PATH}" ]; then
	echo "Installing Command-Line-Tools and Xcode 5"
	xcode-select --install
fi

echo
echo
echo "Running boxen for the first time"
/opt/boxen/script/boxen

echo "Adding boxen to ~/.bash_profile"
echo "[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh" >> $HOME/.bash_profile



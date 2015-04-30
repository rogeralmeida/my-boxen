GIT_USER=`git config --get user.name`
if [ -z ${GIT_USER} ]; then
	echo -n "Please enter your git user.name: "
	read GIT_USER
	git config --global user.name "${GIT_USER}"
fi

echo "Installing Command-Line-Tools and Xcode 5"
xcode-select --install

if [ ! -d /opt ]; then
	mkdir /opt
fi
echo "Creating link in /opt"

cd /opt && sudo ln -s $HOME/my-boxen boxen
sudo chown -R $USER  /opt/boxen

echo "Running boxen for the first time"
/opt/boxen/script/boxen

echo "Adding boxen to ~/.bash_profile"
echo "[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh" >> $HOME/.bash_profile



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



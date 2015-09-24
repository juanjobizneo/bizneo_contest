sudo apt-get install curl libqt5webkit5-dev g++ qt5-default
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
echo "#####################################################################"
echo " EJECUTA 'source $HOME/.rvm/scripts/rvm' en todos tus terminales"
echo "#####################################################################"
echo "source $HOME/.rvm/scripts/rvm" >> $HOME/.bashrc
source $HOME/.rvm/scripts/rvm
rvm use 2.2.1 --default
gem install capybara
gem install selenium-webdriver
gem install capybara-webkit


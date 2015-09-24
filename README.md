# bizneo_contest
Manual de instalación y ejemplos para:
* La sesión formativa del Jueves 24 de Septiembre de 2015 a las 13:00 en la Escuela Superior de Informática de Ciudad Real, en el LD6.
* Taller Agile-CR Scraping y Bots http://bit.ly/1PonTbv

## Ruby

### Instalación (Linux)
```
$ sudo apt-get install curl libqt5webkit5-dev g++ qt5-default
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ \curl -sSL https://get.rvm.io | bash -s stable
$ echo "source $HOME/.rvm/scripts/rvm" >> $HOME/.bashrc
$ source $HOME/.rvm/scripts/rvm
$ rvm use 2.2.1 --default
$ gem install capybara
$ gem install selenium-webdriver
$ gem install capybara-webkit
```

### Instalación (OSx)
```
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ \curl -sSL https://get.rvm.io | bash -s stable
$ source $HOME/.rvm/scripts/rvm
$ rvm use 2.2.1 --default
$ gem install capybara
$ gem install selenium-webdriver
$ gem install capybara-webkit
```
## Python (Es optativo)

### Instalación Python (Linux)
```
$ wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz
$ tar -xzf Python-2.7.9.tgz
$ cd Python-2.7.9
$ ./configure 
$ make 
$ sudo make install 
```
### Instalación de las bibliotecas necesarias para creación de bots
```
$ sudo pip install -U selenium
```


Si quieres enviarnos tu currículum, estos son nuestros e-mails:

* diego.arenal@bizneo.com
* juanjo.rivera@bizneo.com
* david.valero@bizneo.com

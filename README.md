# bizneo_contest
Manual de instalación y ejemplos para la sesión formativa del Jueves 19 de Febrero de 2015 a las 12:30 en la Escuela Superior de Informática de Ciudad Real.

## Ruby

### Instalación Ruby (Linux)
```
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ \curl -sSL https://get.rvm.io | bash -s stable --ruby
$ source ~/.rvm/scripts/rvm
```

### Instalación de las bibliotecas necesarias para creación de bots
```
$ gem install capybara
$ gem install 'selenium-webdriver' -v '2.45.0.dev3'
```

## Python

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

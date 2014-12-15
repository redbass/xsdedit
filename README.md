xsdedit
=======

webapp xsd editor


First run
---------

1. Install grunt: `sudo npm install -g bower grunt-cli`

2. Install nodejs packages: `npm install`



# Troubleshooting

## OSX

### Compass
If some error related with compass package occur try:

    sudo gem update --system && sudo gem install compass

If still impossible to install compass try to re/install ruby developement tools:

    xcode-select --install
    
## Ubuntu

### Compass
If some error occur on compile sass code check _ruby_ version 

    ruby --version

have to be `1.9.3`. Also uninstall _compass_ and _sass_:

    sudo gem uninstall compass sass

  
and then force to reinstall 

    sudo gem1.9.3 install compass
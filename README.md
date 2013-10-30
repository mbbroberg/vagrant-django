#revolvemagazine.dk

Main wordpress website [http://revolvemagazine.dk](http://revolvemagazine.dk).

## Getting started:

### Requirements
Make sure you have the following software installed before proceding:

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](http://www.vagrantup.com/)
* [git](http://git-scm.com/) (Linux only)
* [GitHub](http://windows.github.com/) (Windows only)

#### Linux instuctions
First you need to set up git following [this](https://help.github.com/articles/set-up-git#platform-linux) tutorial and then you need to have a SSH key generated and added to your GitHub account, just follow [this](https://help.github.com/articles/generating-ssh-keys#platform-linux) tutorial.
When done just enter the following commands:

    $ git clone git@github.com:revolve-dk/revolve.dk.git
    $ ssh-add ~/.ssh/id_rsa
    $ cd revolve.dk
    $ vagrant up

The first time it will take some time (15-30 min.), when done you can go to [http://localhost:8080](http://localhost:8080) and the application should come up.

#### Windows instuctions


## Project structure

* __configs__: Contains different configuration files for services needed to run Django.
* __django__: This is the folder that you are interested in, it contains the Django project and files.
* __logs__: Contains all logs, including Django.
* __puppet__: Contains [puppet](http://puppetlabs.com/) manifest and module files which are used to install needed packages and set-up the virtual machine to be ready for developement.
* __scripts__: Folder containing [bash](http://stackoverflow.com/questions/2872041/is-there-any-use-for-bash-scripting-anymore) or python scripts used to automate different tasks.
* __.gitattributes__: Ensure consistent git settings across machines, right now used to deal with those pesky [new line endings](http://en.wikipedia.org/wiki/Newline#Representations) differences.
* __.gitignore__: Files to be [ignored](https://help.github.com/articles/ignoring-files) by git and not added to the repository.
* __README.md__: You are reading it now :) . For more info read about [Markdown](http://en.wikipedia.org/wiki/Markdown).
* __Vagrantfile__: [Vagrant configuration file](http://docs.vagrantup.com/v2/vagrantfile/), it is used to create and bring the virtual machine up, configure networking for it and further kick-off puppet.

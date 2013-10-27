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

    $ git clone git@github.com:revolve-dk/revolvemagazine.dk.git
    $ ssh-add ~/.ssh/id_rsa
    $ vagrant up

The first time it will take some time (15-30 min.), when done you can go to [http://localhost:8080](http://localhost:8080) and the application should come up.

#### Windows instuctions

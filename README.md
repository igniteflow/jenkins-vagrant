# vagrant-jenkins

Using Vagrant, a Makefile and shell provisoner scripts allows the easy creation of a running Jenkins instance.  Once dependencies are met (Vagrant and VirtualBox) and configuration is setup, installation is simply `make install` and Jenkins will be available on [http://localhost:9999/](http://localhost:9999/)

## Requirements

Ensure you have the following installed:


[Vagrant >=1.4.3](http://www.vagrantup.com/downloads.html)

[VirtualBox >= 4.3.6](https://www.virtualbox.org/wiki/Downloads)


_For Ubuntu 13.10 users, these dependencies can be installed with ./scripts/setup-ubuntu-client.sh_

## Getting Started

Once you have the correct versions of Vagrant and VirtualBox install run:

    git clone git@github.com:igniteflow/jenkins-vagrant.git
    cd jenkins-vagrant
    make install

Here are some options to customise your instance:

1.  (Optional) Copy `./config.json.example` to `./config.json` and populate with your settings.  The configuration file is a list of Jenkins job names and the absolute path to their Jenkins job config.xml.  The jobs folders will be created under `./jenkins/jobs/` and the config.xml files will be copied into them.  If you don't have an existing Jenkins job, then skip this step and just create the job directly in Jenkins once booted.
2.  (Optional) Add your project specific dependencies to provisioners/shell/project.sh.  An example script for a Python project requiring MySQL, virtualenv, pip and Ruby dependencies can be found at provisioners/shell/project.sh.example.  Enable this provisoner in the next step.
3.  (Optional) Choose your provisioners.  By default only Jenkins will be installed.  If you require NodeJS, Appengine or project specific dependencies then uncomment the provisoner script calls in the Vagrantfile under `# provisioners`
4.  (Optional) Add/remove required Jenkins plugins in `./jenkins/plugins`
5.  Run `make install` - this command will import the VM and install all the dependencies.  Once completed
(took 8m34.655s on an Dell XPS 13 Xubuntu 13.10) visit Jenkins at [http://localhost:9999/](http://localhost:9999/)

## Make commands

Command | Description
--------|---------------------------------------
`make install` | Installs the VM and boots Jenkins
`make rebuild` | Detroys the VM and reinstalls
`make destroy` | Shortcut for `vagrant destroy`
`make update`  | Run the provisioner scripts listing in the Vagrantfile without rebooting the VM
`make prepare` | Ubuntu only.  Prepare the client machine by installing required versions of Vagrant and Virtualbox.


## Notes

- The amount of RAM allocated to the VM is specified in the Vagrantfile under vb.customize.  Adjust this as necessary.
- The `./jenkins/provisionsers/shell/jenkins.sh` script copies your `~/.netrc` and `~/.ssh/id_rsa.pub` to the project
root.  This files are in .gitignore and will not be added to the repo.  They are required so that Jenkins can access
remote Git and Google Code repositories.

## Future

Use a different provisioners - Chef, Puppet, Salt, Docker (?) to be OS agnostic

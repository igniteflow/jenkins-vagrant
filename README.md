# vagrant-jenkins

Using Vagrant, a Makefile and shell provisoner scripts allows the easy creation of a running Jenkins instance.

## Requirements

Install:


[Vagrant >=1.4.3](http://www.vagrantup.com/downloads.html)

[VirtualBox >= 4.3.6](https://www.virtualbox.org/wiki/Downloads)


_For Ubuntu 13.10 users, these dependencies can be installed with ./scripts/setup-ubuntu-client.sh_

## Getting Started

With requirements satisfied the following three commands will result in Jenkins being available on [http://localhost:9999/](http://localhost:9999/):

    git clone git@github.com:igniteflow/jenkins-vagrant.git
    cd jenkins-vagrant
    make install

Here are some options to customise your instance:

1.  **Add existing Jenkins jobs** Copy `./config.json.example` to `./config.json` and populate with your settings.  The configuration file is a list of Jenkins job names and the absolute path to their Jenkins job config.xml.  The jobs folders will be created under `./jenkins/jobs/` and the config.xml files will be copied into them.  If you don't have an existing Jenkins job, then skip this step and just create the job directly in Jenkins once booted.
2.  **Install project specific dependencies** to `provisioners/shell/project.sh`.  An example script for a Python project requiring MySQL, virtualenv, pip and Ruby dependencies can be found at provisioners/shell/project.sh.example.  Enable this provisoner in the next step.
3.  **Add more provisioners**  By default only Jenkins and its dependencies will be installed.  If you require NodeJS, Appengine or project specific dependencies then uncomment the required provisoner script calls in the Vagrantfile under `# provisioners`.  Note that you can re-run provisioner scripts without having to reboot the VM with `make update`
4.  **Add/remove Jenkins plugins**  Edit the following file `./jenkins/plugins`

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

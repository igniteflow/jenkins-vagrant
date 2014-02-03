#!/usr/bin/env python

# Symlinking would be preferable to copying the files in places, however symlinks on the guest machine
# are not visible in the client via VirtualBox.  Tried a few workarounds for this, but no success

import json
import subprocess

from os.path import expanduser, exists

JOBS = 'jenkins/jobs'
HOME = expanduser("~")


def reset():
    subprocess.call(['rm', '-rf', '.netrc'])
    subprocess.call(['rm', '-rf', JOBS + '/*'])


def initialise():
    subprocess.call(['mkdir', '-p', JOBS])
    if exists('config.json'):
        with open('config.json') as f:
            config = json.loads(f.read())

            # create the Jenkins job directory and copy in the config.xml files
            for project in config['projects']:
                project_name, config_xml = project
                project_job_dir = '%s/%s' % (JOBS, project_name)
                subprocess.call(['mkdir', '-p', project_job_dir])
                subprocess.call(['cp', '-f', config_xml, project_job_dir])

    # copy the .netrc file.  in the guest VM this will be available in /vagrant/.netrc which is
    # symlinked by provisioners/shell/jenkins.sh to the Jenkins home directory, which is
    # /var/lib/jenkins - required for Google Code authentication
    subprocess.call(['cp', '-f', HOME + '/.netrc', '.'])

    # copy the SSH public key for Git(Hub) authentication
    subprocess.call(['cp', '-f', HOME + '/.ssh/id_rsa.pub', '.'])

initialise()

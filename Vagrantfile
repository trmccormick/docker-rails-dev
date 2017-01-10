# -*- mode: ruby -*-
# vi: set ft=ruby :

# Commands required to ensure correct docker containers
# are started when the vm is rebooted.

VAGRANTFILE_API_VERSION = "2"
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'
DOCKER_HOST_NAME = "dockerhost"
# DOCKER_HOST_VAGRANTFILE = "DockerHostVagrantfile"
DOCKER_HOST_VAGRANTFILE = "docker-host-vm/Vagrantfile"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define 'database' do |db|
    db.vm.provider "docker" do |d|
      d.image="mysql:latest"
      d.env = {
        # :MYSQL_ROOT_PASSWORD => "root",
        # :MYSQL_DATABASE     => "dockertest",
        # :MYSQL_USER         => "dockertest",
        # :MYSQL_PASSWORD     => "d0cker"

        # during development you may want to use no passwords
        # comment the line below if you have uncommented and set passwords above
        # make sure you update your /config/database.yml to match

        :MYSQL_ALLOW_EMPTY_PASSWORD => true
      }
      d.name = 'mysql'
      d.remains_running = true
      d.ports = ["3306:3306"]
      d.vagrant_machine = "#{DOCKER_HOST_NAME}"
      d.vagrant_vagrantfile = "#{DOCKER_HOST_VAGRANTFILE}"
    end
  end

  config.vm.synced_folder "./example-rails-app", "/myapp"
  config.vm.define 'myapp' do |a|
    a.vm.provider "docker" do |d|
      d.build_dir = "."
      d.name = 'myapp'
      d.link("mysql:mysql")
      d.remains_running = true
      d.ports = ["3000:3000"]
      d.vagrant_machine = "#{DOCKER_HOST_NAME}"
      d.vagrant_vagrantfile = "#{DOCKER_HOST_VAGRANTFILE}"
    end
  end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "openldap"

  config.vm.network "forwarded_port", guest: 22, host: 11822, id:"ssh"
  config.vm.network "private_network", ip: "192.168.33.18"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 60000]
  end

  config.vm.provision :shell do |sh|
    # provision.shでは、ansibleをインストールし、
    # sh.argsで指定されているplaybookとinventoryを使って
    # provisioningを実行する。(local指定)
    sh.path = "provision.sh"

    # ansible-playbookコマンドに渡す。
    # hostsには、上のconfig.vm.networkで定義しているipアドレスを書く。
    # localhostでもいいはずだが。
    sh.args = "openldap.yml hosts"
  end

  # ↑
  # ホントは以下のようにしたいが、実行ホストがWindowsだといろいろ制約が。
  # このようにできればhostsファイルの用意は不要なのに。
  # config.vm.provision "ansible" do |ansible|
  #   ansible.playbook = "playbook.yml"
  # end

end

Vagrant.configure('2') do |config|

  # configure box to use host http_proxy if
  # vagrant-proxyconf is enabled
  def configure_proxy(vm_def)
    if Vagrant.has_plugin?("vagrant-proxyconf") && ENV['http_proxy']
      vm_def.proxy.http = ENV['http_proxy']
      vm_def.proxy.https = ENV['https_proxy']
      vm_def.apt_proxy.http = ENV['http_proxy']
      vm_def.apt_proxy.https = ENV['https_proxy']
      vm_def.proxy.no_proxy = ENV['no_proxy']
    end
  end

  DEFAULT_VAGRANT_BOX = 'ubuntu/trusty64'

  def set_box(vm_def)
    vm_def.vm.box = ENV['VAGRANT_BOX'] || DEFAULT_VAGRANT_BOX
    if ENV['VAGRANT_BOX_VERSION']
      vm_def.vm.box_version = ENV['VAGRANT_BOX_VERSION']
      vm_def.vm.box_check_update = false
    end
  end

  def configure_vm_size(vm_def)
    if ENV['VAGRANT_VM_MEM']
      vm_def.vm.provider 'virtualbox' do |vb|
        vb.memory = ENV['VAGRANT_VM_MEM']
      end
    end
    if ENV['VAGRANT_VM_CPU']
      vm_def.vm.provider 'virtualbox' do |vb|
        vb.cpus = ENV['VAGRANT_VM_CPU']
      end
    end
  end

  salt_install_args = '-g https://github.com/saltstack/salt.git git v2015.8.0'

  config.vm.define :rackhdsrc01 do |rackhdsrc01|

    configure_proxy(rackhdsrc01)
    set_box(rackhdsrc01)
    configure_vm_size(rackhdsrc01)

    rackhdsrc01.vm.hostname = 'rackhdsrc01'
    rackhdsrc01.vm.network "forwarded_port", guest: 8080, host: 8080

    rackhdsrc01.vm.network "private_network", ip: "192.168.37.2", virtualbox__intnet: "racksrcnet"

    rackhdsrc01.vm.provision "shell", path: "tools/install.sh"

    rackhdsrc01.vm.provider 'virtualbox' do |vb|
      vb.cpus = '2'
      vb.memory = '2048'
    end
  end

  config.vm.define :pxe01 do |pxe01|

    # https://atlas.hashicorp.com/chrismatteson/boxes/iPXE (chosen because it was hosted by atlas)
    # https://github.com/chrismatteson/razordemo
    pxe01.vm.box = "chrismatteson/iPXE"

    # setting this low. vagrant will fail to ssh in, so we don't want to wait.
    pxe01.vm.boot_timeout = 2
    pxe01.ssh.insert_key = false
    pxe01.vm.synced_folder ".", "/vagrant", disabled: true
    pxe01.vm.provider :virtualbox do |vm|
      unless ENV['PXE_NOGUI']
        vm.gui = true
      end
      vm.customize ["modifyvm", :id, "--macaddress1", "080027BCF888"]
      vm.customize ["modifyvm", :id, "--nic1", "intnet"]
      vm.customize ["modifyvm", :id, "--intnet1", "racksrcnet"]
      vm.customize ["modifyvm", :id, "--nicbootprio1", "1"]
      vm.customize ["modifyvm", :id, "--boot1", "net"]
      vm.customize ["setextradata", :id, "VBoxInternal/Devices/pcbios/0/Config/DmiSystemSerial", "pxe01"]
    end
  end

  config.vm.define :pxe02 do |pxe02|

    # https://atlas.hashicorp.com/chrismatteson/boxes/iPXE (chosen because it was hosted by atlas)
    # https://github.com/chrismatteson/razordemo
    pxe02.vm.box = "chrismatteson/iPXE"

    # setting this low. vagrant will fail to ssh in, so we don't want to wait.
    pxe02.vm.boot_timeout = 2
    pxe02.ssh.insert_key = false
    pxe02.vm.synced_folder ".", "/vagrant", disabled: true
    pxe02.vm.provider :virtualbox do |vm|
      unless ENV['PXE_NOGUI']
        vm.gui = true
      end
      vm.customize ["modifyvm", :id, "--macaddress1", "080027BCF889"]
      vm.customize ["modifyvm", :id, "--nic1", "intnet"]
      vm.customize ["modifyvm", :id, "--intnet1", "racksrcnet"]
      vm.customize ["modifyvm", :id, "--nicbootprio1", "1"]
      vm.customize ["modifyvm", :id, "--boot1", "net"]
      vm.customize ["setextradata", :id, "VBoxInternal/Devices/pcbios/0/Config/DmiSystemSerial", "pxe02"]
    end
  end

end

all_systems = [
  {
    /* Required Parameters */
    name             = "tcnhq-sim04"
    node_name        = "tcnhq-prxmx01"
    pool_id          = "svc-herowars-core"
    template         = "rocky_linux_9_x64"
    vm_id            = 204

    /* Optional Parameters */
    acpi  = true
    agent = {
      enabled = true
      timeout = "15m"
      trim    = false
      type    = "virtio"
    }

    # amd_sev        = {} # Not Compatible with 'Privilege Separation' tokens.
    # audio_device   = {}   # Not needed for SIM servers
    # bios           = null # Value provided from VM template
    # boot_order     = []
    # cdrom          = {}   # Not needed for SIM servers
    # clone          = {}   # Value provided from VM template

    cpu = {
      # architecture = null # Value provided from VM template
      cores       = 8
      flags       = ["+aes", "+amd-ssbd", "+ibpb", "+pdpe1gb", "+virt-ssbd"]
      hotplugged  = 0
      limit       = 0
      numa        = true
      sockets     = 1
      type        = "host"
      units       = 1024
      affinity    = ""
    }

    description = "Hero Wars Sim Server, Managed By Terraform"

    # disks          = []
    # tpm_state      = {}   # Research how this works with cloning
    # hostpci        = {}   # Not needed for SIM servers
    # usb            = []   # Not needed for SIM servers
    initialization = {
      datastore_id = "nvme-pool"
      servers      = ["10.69.12.1"]
    }

    keyboard_layout = "en-us"
    # kvm_arguments = null

    machine = "pc"

    memory = {
      dedicated      = 16384
      floating       = 0
      shared         = 0
    }

    numa = {
      device = "numa0"
      cpus   = "0-7"
      memory = 16384
      # hostnodes = ""
      policy = "preferred"
    }

    migrate = false

    network_devices = [
      {
        ipv4_address = "10.69.12.24/24"
        ipv4_cidr    = "24"
        ipv4_gateway = "10.69.12.1"
        ipv4_dns     = ["10.69.12.1"]
        bridge       = "vmbr0"
        disconnected = false
        enabled      = true
        firewall     = false
        mac_address  = ""
        model        = "virtio"
        mtu          = 1480
      # queues       = null
      # rate_limit   = null
        vlan_id      = 112
      # trunks       = []
      }
    ]

    # operating_system comes from template via locals
    # pool_id = null

    protection          = false
    reboot              = false
    reboot_after_update = false

    rng = {
      source    = "/dev/urandom"
      max_bytes = 1024
      period    = 1000
    }

    # serial_devices = []  # Not needed for SIM servers
    # scsi_hardware = null # Not needed for SIM servers
    # smbios        = null # Value provided from VM template

    started = true
    startup = {
      order      = 0
      up_delay   = 10
      down_delay = 10
    }

    tablet_device   = true
    # template        = false  # Commented to avoid type mismatches; provide a file_id if needed
    stop_on_destroy = false

    timeout_clone       = 1800
    timeout_create      = 1800
    timeout_migrate     = 1800
    timeout_reboot      = 1800
    timeout_shutdown_vm = 1800
    timeout_start_vm    = 1800
    timeout_stop_vm     = 1800

    # vga                 = {} # Not needed for SIM servers
    # virtiofs            = {} # Not needed for SIM servers
    # hook_script_file_id = null

    watchdog = {
      enabled = false
      model   = "i6300esb"
      action  = "reset"
    }
  }
]
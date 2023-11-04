#################################################################################################
# Source: https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu #
#################################################################################################

####################################################################
#                      Resource Documentation                      #
# ---------------------------------------------------------------- #
# The below section defines the resource; the values below are the #
#   defaults in the resource.                                      #
####################################################################

resource "proxmox_vm_qemu" "kube-node" {
    ciuser      = {{cookiecutter.ssh_username}}
    cicustom    = 
        meta    = 'Custom metadata per node.'
        network = ''
        user    = ''
        vendor  = 'Custom vendor data per node.'
    citype      = nocloud # - This is an appropriate default option for deploying into Linux. configdrive2 for Windows.
    # ipconfig0 - 15: Many interfaces may be specified.
    # searchdomain: DNS search domains.
    # nameserver: DNS server IP address.
    # sshkeys. One key per line.
    ######################################
    # General Specification and Identity #
    ######################################
    name        = 'The VM Name'
    target_node = 'The proxmox node to deploy to.'
    # Setting this to zero causes this to auto-increment
    vmid        = 0
    desc        = 'Shows up in Notes field in proxmox GUI; also can be output.'
    define_connection_info: Let Terraform setup SSH for the preprovisioners.
    # bios        = something

    onboot      = true
    # startup: Not entirely sure
    oncreate    = true
    # tablet: This can be turned on to help with using a mouse in VNC.
    # boot: The boot order by device name.
    agent: Tuen the QEMU Guest Agent on; this can be used to 'properly shut down the guest, among other things'. More research needed.
    iso: The name of the iso to mount to the VM, not used when clone is set.
    pxe: Same story, different boot.
    clone: Take an existing VM.
    full_clone: Linked or independent storage.
    hastate: Requested high availability state - started, stopped, enabled, disabled, ignored; not sure this is appropriate in this case.
    hagroup: Ignore this if not using hastate
    qemu_os: ubuntu e.g.
}
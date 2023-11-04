This adds a terraform structure underneath the cookiecutter project which parametrizes default variables.

* `main.tf`: This file deploys control and worker nodes via [`proxmox_vm_qemu`](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu) resources
* `providers.tf`: This file declares the [Telmate](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs) provider and does some configuration.
* `outputs.tf`: This file exposes a resource mapping output with the IP addresses and names of all the resources.
* `vars.tf`: This file is populated during the cookiecutter deployment and customizes most of the terraform recipe.

<details><summary><h2>providers.tf</h2></summary>
<p>

This introduces:

* {{cookiecutter.telmate_version}}: The provider version string (`"2.9.14"`)


</p>
</details>

<details><summary><h2>`main.tf`</h2></summary>
<p>

```terraform
test
```


</p>
</details> 


<details><summary><h2>QEMU Resource Documentation</h2></summary>
<p>


## Resource Definition

Each resource is built from a cloud-init enabled template and the arguments and options below are documented for downstream documentation. Note the options below.

### [cloud-init specific specification](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/guides/cloud_init)

[Source](https://pve.proxmox.com/wiki/Cloud-Init_Support#_cloud_init_specific_options)

* cicustom:
    * meta=<volume>: Custom metadata per node.
    * network=<volume>: Custom network per node.
    * user=<volume>: Custom user data per node.
    * vendor=<volume>: Custom vendor data per node.
* ciuser: The username for the SSH Keys
* cipassword: This should not be used.
* citype: nocloud - This is an appropriate default option for deploying into Linux. configdrive2 for Windows.
* ipconfig0 - 15: Many interfaces may be specified.
* searchdomain: DNS search domains.
* nameserver: DNS server IP address.
* sshkeys. One key per line.

### General specification

* name: The VM Name
* target_node: The proxmox node to deploy to.
* vmid: Setting this to 0 allows promox to autoincrement and why in the heck isn't this a good idea? Who the hell wants to manage that.
* desc: Shows up in Notes field in proxmox GUI; also can be output.
* define_connection_info: Let Terraform setup SSH for the preprovisioners.
* bios: Probably don't have to screw with this.
* onboot: Turn on when the proxmox node turns on
* startup: Not entirely sure
* oncreate: Start the VM upon creation
* tablet: This can be turned on to help with using a mouse in VNC.
* boot: The boot order by device name.
* agent: Tuen the QEMU Guest Agent on; this can be used to 'properly shut down the guest, among other things'. More research needed.
* iso: The name of the iso to mount to the VM, not used when clone is set.
* pxe: Same story, different boot.
* clone: Take an existing VM.
* full_clone: Linked or independent storage.
* hastate: Requested high availability state - started, stopped, enabled, disabled, ignored; not sure this is appropriate in this case.
* hagroup: Ignore this if not using hastate
* qemu_os: ubuntu e.g.

## Machine OOMPH

* memory: Amount of memory to give to the VM in Megabytes
* balloon: Min amount of ram to use when using auto-allocation
* sockets: Number of cpu sockets.
* cores: Number of cores per socket.
* vcpus: Total number of virtual CPUs plugged in (normally sockets * cores)
* cpu: Type of CPU to emulate
* numa: Whether to use [numa](https://en.wikipedia.org/wiki/Non-uniform_memory_access). It's an interesting thought and is worth parametrizing within this system, if merely to allow testing out the far end for potential optimization points.
* hotplug: "network,disk,usb": Sets it up so you can plug things in and pull them out while the machine is running. A hot pluggable disk sounds like a pretty neat idea.
* scsihw: This is basically a choice of storage device and is influenced by how often you are going to be performing specific styles of disk operations. virtio-scsi-pci is most likely appropriate, further research warranted.
* pool: A VM resource pool to put this into.
* tags: set metadata
* force_create: overwrite previous vm of same name.
* os_type: Provisioning method, choice of ubuntu, centos, cloud-init (reasonably sure cloud init appropriate
* force_recreate_on_change_of: Change this string to force the rebuild.
* os_network_config: This network config is dumped into /etc/network/interfaces to help define network hardware. Update will force recreate.define_connection_info dependent.
* ssh_forward_ip: ip:port to use to connnect to the host for preprovision define_connection_info dependent
* ssh_user: A user to tag the ssh key to. define_connection_info dependent
* ci_wait: How long to wait (s) before preprovision.
* ciuser: Run cloud init as this user.
* cipassword: Why would you use this?
* cicustom: Path to a cloud init config.
* cloudinit_cdrom_storage: Set storage location for cloud init drive; need a hard drive for this?
* searchdomain: Give DNS suffix
* nameserver: Default guest DNS
* sshkeys: Gimme all yo public keys.
* ipconfig0-15 (Does this really only have sixteen values possible?)
* automatic_reboot: auto-reboot when param changes require.

### Different Blocks

* VGA: Specify display characteristics
* Network: Specify network device characteristics
* Disk: Specify multiple disks.
* Serial (experimental)
* USB: Useful for passing through usb devices.

### Attributes
* ssh_host
* default_ipv4_address: Only useful when agent is 1 and proxomox can interrogtae the vm


</p>
</details> 


<details><summary><h2>Terraform Provider Arguments</h2></summary>
<p>

* pm_api_url: Target Proxmox API endpoint.
* pm_user: myuser@pam or myuser@pve.
* pm_password: Do not use this if at all possible.
* pm_api_token_id: API token created for a specific user.
* pm_api_token_secret: This uuid is only available when the token was initially created.
* pm_otp: 2FA OTP
* pm_tls_insecure: For testing ONLY
* pm_parallel: Allowed simultaneous Proxmox processes (4).
* pm_log_enable: Enable debug logging.
* pm_log_levels - (Optional) A map of log sources and levels.
* pm_log_file - (Optional; defaults to "terraform-plugin-proxmox.log") If logging is enabled, the log file the provider will write logs to.
* pm_timeout - (Optional; defaults to 300) Timeout value (seconds) for proxmox API calls.
* pm_debug - (Optional; defaults to false) Enable verbose output in proxmox-api-go
* pm_proxy_server - (Optional; defaults to nil) Send provider api call to a proxy server for easy debugging

</p>
</details> 
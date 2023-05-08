###############################################################################
# Source: https://registry.terraform.io/providers/Telmate/proxmox/latest/docs #
###############################################################################

terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = {{cookiecutter.telmate_version}}
    }
  }
}

####################################################################
#                      Provider Documentation                      #
# ---------------------------------------------------------------- #
# The below section defines the provider; the values below are the #
#   defaults in the provider and are only called out here for ease #
#   of adaptability. This is what the resource uses to deploy.     #
####################################################################

provider "proxmox" {
    ##############################
    # Options to configure debug #
    ##############################
    # pm_debug = true
    # pm_log_enable = true
    # pm_log_file   = "terraform-plugin-proxmox.log"
    # pm_log_levels = {
    #     _default    = "debug"
    #     _capturelog = ""
    # }
    #####################################
    # Options to configure connectivity #
    #####################################
    # Target Proxmox API endpoint.
    pm_api_url = {{cookiecutter.proxmox_api_url}}
    # Proxmox user and domain
    pm_user = {{cookiecutter.ssh_username}}@pve
    # Do not use this if at all possible.
    # pm_password = ''
    # API token created for a specific user.
    pm_api_token_id = {{cookiecutter.proxmox_api_token_id}}
    pm_api_token_secret = {{cookiecutter.proxmox_api_token_secret}}
    # pm_otp: 2FA OTP
    # pm_tls_insecure: For testing ONLY
    # pm_proxy_server - (Optional; defaults to nil) Send provider api call to a proxy server for easy debugging
    ##########################################
    # Options to configure proxmox machinery #
    ##########################################
    # Allowed simultaneous Proxmox processes (defaults: 4)
    pm_parallel = 4
    # Timeout value (seconds) for Proxmox API calls (default: 300)
    pm_timeout = 1200
}
[![Build Status](https://travis-ci.org/oasis-roles/satellite.svg?branch=master)](https://travis-ci.org/oasis-roles/satellite)

SATELLITE
===========

Install and configure a main Satellite server

Requirements
------------

Ansible 2.4 or higher

Red Hat Enterprise Linux 7 or equivalent

Valid Red Hat Subscriptions

Role Variables
--------------

Currently the following variables are supported:

### General

* `satellite_admin_username` - First username to add as an admin of Satellite
* `satellite_admin_password` - Password for the first admin user created
* `satellite_organization` - Name of the organization that owns the Satellite server (e.g. "ABC Corp.")
* `satellite_location` - Location the server is in (e.g. "ABC Corp Main HQ")
* `satellite_proxy_dhcp` - Default: true - enable Satellite proxy DHCP plugin
* `satellite_proxy_dhcp_managed` - Default: true - enable Satellite proxy DHCP plugin management
* `satellite_proxy_dns` - Default: true - enable Satellite proxy DNS plugin
* `satellite_proxy_dns_managed` - Default: true - enable Satellite proxy DNS plugin management
* `satellite_answers_file_destination` - The scenario path to upload this specific set of Foreman
  answers to drive the installation of Satellite

Dependencies
------------

Before the Satellite installer will operate properly, there are a number of tasks that need
to be accomplished on the host system. There are OASIS roles for each one of these tasks, and
some example configuration will be given here.

Minimum hardware requirements include 8GB of RAM. Without that, the Satellite installer will
simply refuse to run, informing you that it needs that much system memory. There are also
significant hard drive space requirements to actually operate Satellite, but the installer will
operate without them. So those can be added to and expanded later on.

Satellite is available in a number of RHSM repositories. Specifically you should have the repos
`rhel-7-server-rpms`, `rhel-server-rhscl-7-rpms`, and `rhel-7-server-satellite-<version>-rpms`
enabled. The `<version>` string should be substituted with the current version of Satellite that
you wish to install. No other repositories should be enabled on the system, to avoid improper
masking of dependencies. This can be done by registering with the
[rhsm](https://github.com/oasis-roles/rhsm/) role using a snippet similar to the following:
```yaml
- hosts: satellite
  roles:
    - role: oasis-roles.rhsm
      rhsm_repositories:
        only:
          - rhel-7-server-rpms
          - rhel-server-rhscl-7-rpms
          - rhel-7-server-satellite-6.3-rpms
      rhsm_unregister: true
```

Satellite is very picky about the hostname for the system, as well. The fully qualified hostname
(such as that reported by `hostname -f`) must be both the forward and reverse DNS name for the
system. The easiest way to do this is by setting up true DNS and also setting the system's
hostname with the [hostname role](https://github.com/oasis-roles/hostname). An option such as this
should accomplish it:
```yaml
- hosts: satellite
  roles:
    - role: oasis-roles.hostname
      hostname: "fqdn.mydomain.tld"
      hostname_inject_hosts_files: false
```

Resolving DNS is not sufficient for the Satellite installer. It also will check that at least one
of the network interfaces on the host system is configured to respond to the IP address that it
detects as the forward DNS host. In some environments, this might not be set on the interface by
default. For instance, most VMs in OpenStack will have a set of internal OpenStack IP addresses that
are on the host, but then an externally routable IP address will be added to the OpenStack network
and that will be the DNS response. However, OpenStack will not configure the host to attach that
routable IP address to the interface. Behavior like this is not uncommon in hosted environments, so
if the target host is in such a situation, an IP address can be added to the default IPv4 interface
with code such as follows:
```yaml
- hosts: satellite
  roles:
    - role: oasis-roles.nmcli_add_addrs
      nmcli_add_addrs_interface: "{{ ansible_default_ipv4.interface }}"
      nmcli_add_addrs_ipv4:
        - "{{ ansible_host | default(inventory_hostname) }}"
```
Obviously, the interface and IP address added will be dependent on the host and the infrastructure
it lives in and they can be added through hard coded means or through auto-detection such as in the
above example. And for hosts that are configured directly with IP addresses that match their DNS
entry, this step can be skipped entirely.

Example Playbook
----------------

```yaml
- hosts: satellite-servers
  roles:
    - role: oasis-roles.satellite
```

License
-------

GPLv3

Author Information
------------------

Author Name <authoremail@domain.net>

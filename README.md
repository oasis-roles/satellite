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

* `satellite_admin_password` - REQUIRED! Password for the first admin user created
* `satellite_admin_username` - First username to add as an admin of Satellite
* `satellite_organization` - Name of the organization that owns the Satellite server (e.g. "ABC Corp.")
* `satellite_location` - Location the server is in (e.g. "ABC Corp Main HQ")
* `satellite_enable_ssl` - Default: true - enable browser SSL access
* `satellite_ssl_port` - Default: 443. The port to listen on for SSL connections
* `satellite_http_port` - Default: 80. The port to serve plain browser traffic
* `satellite_compute_ec2` - Default: false. Enable the Satellite plugin to manage EC2 resources.
* `satellite_compute_gce` - Default: false. Enable the Satellite plugin to manage GCE resources.
* `satellite_compute_libvirt` - Default: false. Enable the Satellite plugin to manage libvirt resources.
* `satellite_compute_openstack` - Default: false. Enable the Satellite plugin to manage OpenStack resources.
* `satellite_compute_ovirt` - Default: false. Enable the Satellite plugin to manage oVirt/RHV resources.
* `satellite_compute_rackspace` - Default: false. Enable the Satellite plugin to manage Rackspace resources.
* `satellite_compute_vmware` - Default: false. Enable the Satellite plugin to manage VMWare resources.
* `satellite_proxy_http_port` - Default: 8000. Port on which to run Satellite HTTP proxy
* `satellite_proxy_http` - Deafult: true. Enable Satellite HTTP proxy
* `satellite_proxy_ssl_port` - Default: 9090. Port on which to run Satellite SSL proxy
* `satellite_proxy_ssl` - Default: true. Enable Satellite SSL proxy
* `satellite_proxy_dhcp` - Default: false. Enable Satellite proxy DHCP plugin. If you enable this, you must
  configure a DHCP server before running this installer.
* `satellite_proxy_dhcp_managed` - Default: true. Enable Satellite proxy DHCP plugin management
* `satellite_proxy_dns` - Default: false. Enable Satellite proxy DNS plugin. If you enable this, you must
  configure a DNS server before running this installer.
* `satellite_proxy_dns_managed` - Default: true. Enable Satellite proxy DNS plugin management
* `satellite_puppet_port` - Default: 8140. Port to run the Puppet server on
* `satellite_answers_file_destination` - The scenario path to upload this specific set of Foreman
  answers to drive the installation of Satellite. This value has reasonable defaults set that match
  the values Foreman uses by default. If you want to store the ansewrs file somewhere else, update
  this value to match. Be sure that this file, which will include the value of `satellite_admin_password`
  in plaintext is not readable by users who should not be able to read it

Unlike many other OASIS project roles, there is no `satellite_become_user` or
`satellite_become` variable. The Satellite installer is very strict about system configuration and
setup. Therefore, all tasks that require it must be executed as root.

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
    - role: oasis_roles.rhsm
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
    - role: oasis_roles.hostname
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
    - role: oasis_roles.nmcli_add_addrs
      nmcli_add_addrs_interface: "{{ ansible_default_ipv4.interface }}"
      nmcli_add_addrs_ipv4:
        - "{{ ansible_host | default(inventory_hostname) }}"
```
Obviously, the interface and IP address added will be dependent on the host and the infrastructure
it lives in and they can be added through hard coded means or through auto-detection such as in the
above example. And for hosts that are configured directly with IP addresses that match their DNS
entry, this step can be skipped entirely.

There are a large number of firewall ports that need to be opened for Satellite to work properly.
Keeping a full list of those ports here is unreasonable and could possibly change with different
versions of Satellite in the future. Therefore, refer to the Satellite
[documentation](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.3/html/installation_guide/preparing_your_environment_for_installation#ports_prerequisites)
for a description of which ports should be opened, and open the ones that you find useful.
At the very least it is probably desirable to open the standard web ports (80 and 443) to allow
browser-based access to the Satellite environment.
```yaml
- hosts: satellite
  roles:
    - role: oasis_roles.firewalld
      firewalld_zone: public
      firewalld_ports_open:
        - proto: tcp
          port: 80
        - proto: tcp
          port: 443
```
the others can be opened if you want to use Satellite for the different purposes served by
those functions.

Example Playbook
----------------

```yaml
- hosts: satellite-servers
  roles:
    - role: oasis_roles.rhsm
      rhsm_repositories:
        only:
          - rhel-7-server-rpms
          - rhel-server-rhscl-7-rpms
          - rhel-7-server-satellite-6.3-rpms
      rhsm_unregister: true
    - role: oasis_roles.hostname
      hostname: "fqdn.mydomain.tld"
      hostname_inject_hosts_files: false
    - role: oasis_roles.nmcli_add_addrs
      nmcli_add_addrs_interface: "{{ ansible_default_ipv4.interface }}"
      nmcli_add_addrs_ipv4:
        - "{{ ansible_host | default(inventory_hostname) }}"
    - role: oasis_roles.firewalld
      firewalld_zone: public
      firewalld_ports_open:
        - proto: tcp
          port: 80
        - proto: tcp
          port: 443
    - role: oasis_roles.satellite
      satellite_admin_username: my_user
      satellite_admin_password: my_derpy_p4ssw0rd
      satellite_organization: Lexcorp, Inc.
      satellite_location: Metropolis, USA
```

License
-------

GPLv3

Author Information
------------------

Greg Hellings <greg.hellings@gmail.com>

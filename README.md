Satellite
=========

This ansible role is used to install and configure Red Hat Satellite 6.6

**This Role does not use the Ansible Foreman modules**

Requirements
------------
#### System Requirement
- x86_64 architecture
- The latest version of Red Hat Enterprise Linux 7 Server
- 4-core 2.0 GHz CPU at a minimum
- A minimum of 20 GB memory is required for Satellite Server to function. In addition, a minimum of 4 GB  of swap space is also recommended. Satellite running with less memory than the minimum value might not operate correctly.
- A unique host name, which can contain lower-case letters, numbers, dots (.) and hyphens (-)
- A current Red Hat Satellite subscription
- Administrative user (root) access
- A system umask of 0022
- Full forward and reverse DNS resolution using a fully-qualified domain name

#### Storage Requirements
- 2 Storage devices
- 80 Gib Storage devices for OS
- Minimum of 720 Gib storage device for Satellite (Connected/Disconnected), maximum of 900 Gib

Information System requiments is found in the links below
- [Connected Satellite](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.6/html/installing_satellite_server_from_a_connected_network/index)   
- [Disconnected Satellite](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.6/html/installing_satellite_server_from_a_disconnected_network/index) 


Role Variables
--------------
#### Enviroment Variables

1. `SAT_ACCOUNT_ID` - Your Red Hat Account Number 
2. `RHN_AK` - Activation key is from access.redhat.com 
   - [To Create an activation key on access.redhat.com](https://access.redhat.com/articles/1378093)
3. `RHN_ORG` - Orgization ID from access.redhat.com
   - [How to look up organization id on Red Hat's Customer Portal](https://access.redhat.com/articles/3047431)
4. `RHN_CONNECT: {connected,disconnect, or master}` - Used to set the method of the satellite installation
   - connected option is system is register to Red Hat's CDN and has access to the internet
   - disconnect optinon is when the system does not have access to the internet
   - master option is the same has connected but exports the rpm content for a disconnected satellite
5. `CONTENT_SOURCE` - The path on where the offline rpm repository is stored
6. `FOREMAN_USER` - Initial admin user
7. `FOREMAN_PASSWORD` - Initial admin user password
8. `FOREMAN_INITIAL_ORGANIZATION` - Set initial organization
9. `FOREMAN_INITIAL_LOCATION` - Set initial location
10. `MANIFEST_UUID` - Manifest uuid that is created on access.redhat.com
    - [Manifest FAQ](https://access.redhat.com/articles/229083)

#### Default Variables

1. `sync_plans_name` - Name of the sync plan
2. `sync_plans_interval` - How often you would like to rpm repositories to be synced
3. `sync_plans_time: '2019/03/01 08:00:00'` - The time you want the rpm repositories to be synced
4. `sync_plan_enabled` - Enable(true) or disable(false) sync plan

Dependencies
------------
Create satellite manifest from access.redhat.com before hand. If the satellite connected to the internet the role will pull down the manifest  
from access.redhat.com

[Manifest FAQ](https://access.redhat.com/articles/229083)

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: satellite }

License
-------

BSD

Author Information
------------------

Cory McKee (cmckee@redhat.com)

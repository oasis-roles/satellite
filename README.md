Satellite
=========

Satellite role is a ansible role to install and configure Red Hat Satellite 6.6
This Role does not use the Ansible Foreman modules

Requirements
------------
System Requirements
- x86_64 architecture
- The latest version of Red Hat Enterprise Linux 7 Server
- 4-core 2.0 GHz CPU at a minimum
- A minimum of 20 GB memory is required for Satellite Server to function. In addition, a minimum of 4 GB  of swap space is also recommended. Satellite running with less memory than the minimum value might not operate correctly.
- A unique host name, which can contain lower-case letters, numbers, dots (.) and hyphens (-)
- A current Red Hat Satellite subscription
- Administrative user (root) access
- A system umask of 0022
- Full forward and reverse DNS resolution using a fully-qualified domain name

Information System requiments is found in the links below
- [Connected Satellite](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.6/html/installing_satellite_server_from_a_connected_network/index)   
- [Disconnected Satellite](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.6/html/installing_satellite_server_from_a_disconnected_network/index) 

Storage Requirements
- 2 Storage devices
- 80 Gib Storage devices for OS
- Minimum of 720 Gib storage device for Satellite (Connected/Disconnected), maximum of 900 Gib

***Role Variables***
--------------
--------------
Enviroment Variables
--------------
1. SAT_ACCOUNT_ID is your Red Hat Account Number 
   - **SAT_ACCOUNT_ID**=*{Red Hat Account Number}*
2. Activation key is from access.redhat.com 
   - [To Create an activation key on access.redhat.com](https://access.redhat.com/articles/1378093)
   - **RHN_AK**=*{Activation key that was created on access.redhat.com}*
3. RHN_ORG is from access.redhat.com
   - [How to look up organization id on Red Hat's Customer Portal](https://access.redhat.com/articles/3047431)
   - **RHN_ORG**=*{Activation Keys for Organization ID number}*
4. RHN_CONNECT variable is used to set the method of the satellite installation
   - **RHN_CONNECT**=*{connected,disconnect, or master}*
     - connected option is system is register to Red Hat's CDN and has access to the internet
     - disconnect optinon is when the system does not have access to the internet
     - master option is the same has connected but exports the rpm content for a disconnected satellite
5. CONTENT_SOURCE is the path on where the offline rpm repository is stored
   - **CONTENT_SOURCE**=*{FQDN}*
6. FOREMAN_USER is to set the initial admin user for the satellite
   - **FOREMAN_USER**=*{admin}*
7. FOREMAN_PASSWORD is set for the initial admin user password
   - **FOREMAN_PASSWORD**=*{changeme}*
8. FOREMAN_INITIAL_ORGANIZATION is set for initial Organization
   - **FOREMAN_INITIAL_ORGANIZATION**=*{Example}*
9. FOREMAN_INITIAL_LOCATION is set for initial location
   - **FOREMAN_INITIAL_LOCATION**=*{San Antonio}*
10. MANIFEST_UUID is the manifest uuid that is created on access.redhat.com
    - [Manifest FAQ](https://access.redhat.com/articles/229083)
    - **MANIFEST_UUID**=*{CHANGEME-F4K3-UU1D-9h0i-1j2k3l4m5n60}* 

Default Variables
--------------
1. sync_plans_name is the name of the sync plan
   - **sync_plans_name:** 'Nightly_Midnight_Sync'
2. sync_plans_interval is how often you would like to rpm repositories to be synced
   - **sync_plans_interval:** daily
3. sync_plans_time is when you want the rpm repositories to be synced
   - **sync_plans_time:** '2019/03/01 08:00:00'
4. sync_plan_enabled is set for the sync plan to be enabled or disabled
   - **sync_plan_enabled:** true

Dependencies
------------
Create satellite manifest from access.redhat.com before hand, currently stored on the gitlab runner, but will be stored on an s3 bucket.
 The manifest must be updated manually until we get the api for access working.
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
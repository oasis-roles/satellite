# Changes
commit dba807b8ffc2a66fefb40382752eabef59d39da2
Merge: 814bd62 a4d14b3
Author: Jonny Rickard <jrickard@us-gov-west-1.compute.internal>
Date:   Thu Oct 10 02:33:12 2019 +0000

    Merge branch '46-fix-issue-with-software-collection-enable-repo-and-add-to-content-view' into 'dev'
    
    Resolve "Fix issue with software collection enable repo and add to content view"
    
    Closes #46
    
    See merge request levelup-automation/systems/satellite!22

commit 814bd622a31264bfbd80f9baf1e4fb3737542f40
Merge: 113aa79 c8f6b3d
Author: Chris Kuperstein <ckuperst@redhat.com>
Date:   Tue Oct 8 17:36:31 2019 +0000

    Merge branch '53-satellite-password-has-which-is-affecting-registration' into 'dev'
    
    "RHN account password has '$' which is affecting registration"
    
    Closes #53
    
    See merge request levelup-automation/systems/satellite!24

commit 113aa792601a6b36601bad901c1afa69526f1c31
Merge: 145e094 0e90a34
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Thu Oct 3 16:44:53 2019 +0000

    Merge branch '43-run-yum-clean-all-on-system-before-installing-any-packages' into 'dev'
    
    add a yum clean all
    
    Closes #43
    
    See merge request levelup-automation/systems/satellite!21

commit 145e0946b2cbcf5078d846ff158365ec630b374f
Merge: 4388376 8e127a9
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Wed Oct 2 21:56:31 2019 +0000

    Merge branch '45-host-the-helm-client-binary-tar-ball-in-satellite' into 'dev'
    
    Resolve "Host the helm client binary tar-ball in satellite"
    
    Closes #45
    
    See merge request levelup-automation/systems/satellite!20

commit 438837625ca2a5135ffec9fe3f3c0dd2e9ab3adb
Merge: 533972b 6b1a329
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Wed Oct 2 20:10:36 2019 +0000

    Merge branch 'patch-1' into 'dev'
    
    Update organization_config.yml
    
    See merge request levelup-automation/systems/satellite!19

commit 533972b17824001e9593e300e7aeceb0294e5d5f
Merge: 496c4aa 350f352
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Fri Sep 27 17:20:40 2019 +0000

    Merge branch '18-turn-on-fips' into 'dev'
    
    enabling FIPS
    
    Closes #18
    
    See merge request levelup-automation/systems/satellite!18

commit 496c4aa37044f5f9d1029a5ee76995eb5b1f04b6
Merge: 7870ff1 0c075ce
Author: Cory McKee <cmckee@us-gov-west-1.compute.internal>
Date:   Thu Sep 26 17:19:18 2019 +0000

    Merge branch '41-remove-ci-cd-lookups-for-non-sensitive-information' into 'dev'
    
    removing ci/cd lookups for non sensitive information
    
    Closes #41
    
    See merge request levelup-automation/systems/satellite!17

commit 7870ff1d998c074ec3b23cae5f9ae44a8fb137dc
Merge: b8df538 e00bee9
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Thu Sep 26 15:46:46 2019 +0000

    Merge branch '40-remove-organization-id-from-playbooks' into 'dev'
    
    removed extra sync, replaced org.id with org.name
    
    Closes #40
    
    See merge request levelup-automation/systems/satellite!16

commit b8df538730f967a22b58e148bc592b19d9d464f5
Merge: 1a54d9a 6b23fe0
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Thu Sep 26 01:27:22 2019 +0000

    Merge branch '39-remove-enable-repos-in-defaults-main-yml' into 'dev'
    
    Resolve "Remove enable Repos in defaults/main.yml"
    
    See merge request levelup-automation/systems/satellite!14

commit 1a54d9a32ee428d357296045082442e0d0eac3d1
Merge: 5796569 90009cb
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Wed Sep 25 17:47:13 2019 +0000

    Merge branch '38-fix-defaults-main-yml-for-naming-of-software-collections' into 'dev'
    
    Update main.yml removed "parentheses from software collections name
    
    See merge request levelup-automation/systems/satellite!13

commit 579656971c9dc36ad7526e7883f10531b5a18095
Merge: 19c0a0a 57b500d
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Wed Sep 25 16:06:51 2019 +0000

    Merge branch '37-remove-repo-sync-from-organization_config-yml' into 'dev'
    
    Resolve "remove repo sync from organization_config.yml"
    
    See merge request levelup-automation/systems/satellite!12

commit 19c0a0a6788e3125d9d5c1542067c61a188f8f69
Merge: c0d28e4 c37f6e5
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Wed Sep 25 02:56:05 2019 +0000

    Merge branch '36-update-software-collections-in-default-variables' into 'dev'
    
    Resolve "Update software collections in default variables"
    
    See merge request levelup-automation/systems/satellite!11

commit c0d28e4f414dc8087dbd13d30ad57bd2da3f66a2
Merge: 434d3d6 6f8e332
Author: Cory McKee <cmckee@us-gov-west-1.compute.internal>
Date:   Tue Sep 24 14:28:50 2019 +0000

    Merge branch '23-configure-activation-keys-in-satellite' into 'dev'
    
    Resolve "Configure activation keys in Satellite"
    
    See merge request levelup-automation/systems/satellite!10

commit bb2293eb35a11d39a7584b912e7e9d716b1676dd
Merge: 98dbf77 b794449
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Sat Sep 21 19:28:46 2019 +0000

    Merge branch 'mholmes-gitissue3' into 'registry'
    
    updating custom content
    
    See merge request levelup-automation/systems/satellite!9

commit 98dbf7704f05a1612c67874b1c896ffe700a9af7
Merge: fd20ec6 f79e967
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Sat Sep 21 05:27:05 2019 +0000

    Merge branch 'mholmes-gitissue3' into 'registry'
    
    reordering custom repos to content views
    
    See merge request levelup-automation/systems/satellite!8

commit fd20ec6c9a9210eb41bdab61b90d2d341dbe5992
Merge: a8e10ef 25ef0e7
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Sat Sep 21 01:38:32 2019 +0000

    Merge branch 'mholmes-gitissue3' into 'registry'
    
    Changing org and location to generic terms
    
    See merge request levelup-automation/systems/satellite!7

commit a8e10ef9034d1db8923f0baf3f032156d1bb802d
Merge: 0d72373 9d0efb2
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Fri Sep 20 22:01:08 2019 +0000

    Merge branch 'mholmes-gitissue3' into 'registry'
    
    updating lookups
    
    See merge request levelup-automation/systems/satellite!6

commit 0d723738c04a6923898f6da1949db1afc1d36019
Merge: 96ebc61 08ad2a3
Author: Mike Holmes <mholmes@us-gov-west-1.compute.internal>
Date:   Fri Sep 20 21:54:49 2019 +0000

    Merge branch 'mholmes-gitissue3' into 'registry'
    
    updating syntax
    
    See merge request levelup-automation/systems/satellite!5

    Merge branch 'registry' of gitlab.cyberfactory.io:unified-platform/systems/satellite into registry
# Known Issues
1. Run the playbook multiple time on a system thst already been deployed cause server to slow to respond
2. Composite Content Views not created
3. Disconnetced Satellite option
4. Content View publishing is one at a time sync not all at once
5. Local authenication is used not a central authenication source
6. Clean up of entitlements on RHN when satellite is decommission

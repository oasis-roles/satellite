#!/bin/bash

# this variable selects the latest published version available in the content view and will be passed as a parameter to hammer
# Script to publish monthly content views
CONTENT_VIEW=`hammer content-view list | grep -v -e true -e Default_Organization_View -e CONTENT -e "--"|awk '{print $1}'`
REPO=`hammer repository list | grep -v -e "--" | awk '{print $1 }'`
#foreman-rake foreman_tasks:cleanup TASK_SEARCH='label ~ *' AFTER='1d' VERBOSE=true

for x in $REPO
do
    hammer repository synchronize --id $x --organization-id 1 --async
done

SYNC=`hammer product list  --organization-id 1 | grep -i running| wc -l`
while [ $SYNC != 0 ]
do
    echo "repos are still syncing "
    hammer product list  --organization-id 1 | grep -i running | awk -F "|" '{print $2 }'
    sleep 360
    SYNC=`hammer product list  --organization-id 1 | grep -i running| wc -l`
done
logger "Publishing Monthly Content Views"
for x in $CONTENT_VIEW
do
/bin/hammer content-view publish --organization-id 1 --id $x  --description 'latest monthly RPMs' --async
done

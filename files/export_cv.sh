#!/bin/bash
# Script to export a content view and uploaded to amazon S3 bucket
LATEST_VERS=`/bin/hammer content-view version list --content-view "export"  --organization-id 1 |awk '{print $6}'|sort -nr | head -n1`
CONTENT_VIEW=`hammer content-view version list | grep export | grep  $LATEST_VERS |  awk '{print $1}'`
DATE=`date +%F`
TAR=`ls /var/lib/pulp/katello-export/ | awk '{print $1}'`

jfrog() {
/usr/bin/which jfrog > /dev/null 2>&1
if [ $? != 0 ]; then
     echo "Downloading jfrog binary from https://getcli.jfrog.io and installing"
     curl -fL https://getcli.jfrog.io | sh
     mv jfrog /usr/local/bin
     chmod 755 /usr/local/bin/
  else
    echo "jfrog is already installed"
fi

/usr/bin/trust list | grep -i dod > /dev/null 2>&1
if [ $? != 0 ]; then
    echo "If dod root chain is not in the trust list, download and install the certificates and put them in place"
    curl -L https://dl.dod.cyber.mil/wp-content/uploads/pki-pke/zip/unclass-certificates_pkcs7_v5-8_wcf.zip -o /tmp/unclass-certificates_pkcs7_v5-8_wcf.zip | unzip /tmp/unclass-certificates_pkcs7_v5-8_wcf.zip -d /tmp/
    echo "Moving root certificate to /etc/pki/ca-trust/source/anchors"
    find /tmp -name *.pem | xargs -I '{}' mv '{}' /etc/pki/ca-trust/source/anchors/
    echo "updating the ca store with the dod certs"
    update-ca-trust extract
fi
}

awscli (){
which aws > /dev/null 2>&1
  if [ $? != 0 ]; then
      echo "Downlaoding and installing awscli"
      curl -LO https://s3.amazonaws.com/aws-cli/awscli-bundle.zip | unzip awscli-bundle.zip -d /tmp/
      /tmp/awscli-bundle/install -i /usr/local/bin/aws -b /bin/aws

      aws --version > /dev/null 2>&1
        if [ $? == 0 ]; then
           rm -rf /tmp/awscli-bundle
           rm -rf /tmp/awscli-bundle.zip
        fi
  else
      echo "aws cli is already installed on this system"
  fi
}
# Ensure some pre-requisite packages are installed
prereqs(){
for pkg in unzip zip python-gssapi bash-completion
 do
     /usr/bin/rpm -qa |grep ^${pkg} > /dev/null 2>&1
     if [ $? != 0 ]; then
         yum -y install ${pkg}
     fi
 done

if [ ! -d ${HOME}/miniconda2 ]; then
    echo "downloading miniconda"
    curl -Lf https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh -o miniconda2.sh
    echo "running miniconda installer"
    bash miniconda2.sh -b -p ${HOME}/miniconda2
fi

export PATH=${HOME}/miniconda2/bin:${PATH}
pip install --upgrade pip --trusted-host pypi.org --trusted-host files.pythonhosted.org
pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org boto boto3 --user

}
#clean up everything
cleanup(){
rm -rf ${HOME}/miniconda2
rm -rf ${HOME}/miniconda2.sh
rm -rf /tmp/unclass-certificates_pkcs7_v5-8_wcf.zip
rm -rf /tmp/Certificates_PKCS7_v5.8_WCF
}

# Run the script
prereqs
#Call function to install and configure jfrog
jfrog
#Call function to install and configure awscli
awscli
#Run the cleanup function
cleanup

#Remove old content
logger "removing $TAR"
for x in $TAR
 do
 rm -rf $x
done



#export content view
logger "Exporting the export content view"
hammer content-view version export --export-dir /var/lib/pulp/katello-export --id $CONTENT_VIEW

# Splitting the export tar ball
mkdir  /var/lib/pulp/katello-export/$DATE
logger "Spliting tar to 4G size"
TAR=`ls /var/lib/pulp/katello-export/ |grep $LATEST_VERS | awk '{print $1}'`
echo "spliting $TAR"
split -b4G  /var/lib/pulp/katello-export/$TAR "/var/lib/pulp/katello-export/$DATE/$TAR-satellite_content"

# Syncing to Amazon s3 bucket
logger "pushing content to S3 bucket"
 /usr/local/bin/aws s3 sync /var/lib/pulp/katello-export/$DATE/.  s3://u1-cdn-s3/satellite/$DATE/

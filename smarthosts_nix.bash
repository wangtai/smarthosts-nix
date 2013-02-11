#!/bin/bash 

TMP_DIR=/tmp
SMARTHOSTS_GOOGLECODE_COM=203.208.46.222

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
    echo "This script. must be run as root" 
    exit 1
fi

wget --header="Host: smarthosts.googlecode.com" "https://${SMARTHOSTS_GOOGLECODE_COM}/svn/trunk/hosts" --no-check-certificate -O ${TMP_DIR}/hosts.cfw

awk 'BEGIN{AUTO_HOST=0} \
        { \
            if($0=="###S.M.T.NIX START###"){ \
                    AUTO_HOST=1 \
            } \
            if(AUTO_HOST==0){ \
                    print $0 \
            } \
            if($0=="###S.M.T.NIX END###"){ \
                    AUTO_HOST=0 \
            } \
        }' /etc/hosts > ${TMP_DIR}/hosts.origin


cat ${TMP_DIR}/hosts.origin > /etc/hosts
echo "###S.M.T.NIX START###" >> /etc/hosts
cat ${TMP_DIR}/hosts.cfw |sed 's/\r//g'  >> /etc/hosts
echo "###S.M.T.NIX END###" >> /etc/hosts

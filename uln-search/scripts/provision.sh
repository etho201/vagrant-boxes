#!/bin/bash

dnf install -y rhn-setup
ulnreg_ks --username=${USERNAME} --password=${PASSWORD} --csi=${CSI}
uln-channel -u ${USERNAME} -p ${PASSWORD} --enable-yum-server

# # Remove all channels
# CHANNEL_LIST=
# for i in $(uln-channel -u ${USERNAME} -p ${PASSWORD} -l); do
#     if [[ $i != "ol7_x86_64_latest" ]]; then # System must have at least one subscription
#         CHANNEL_LIST+=" -c ${i} -r"
#     fi
# done
# uln-channel -u ${USERNAME} -p ${PASSWORD} $CHANNEL_LIST

# Add channels
CHANNEL_LIST=
for i in $(uln-channel -u ${USERNAME} -p ${PASSWORD} -L); do
    if [[ $i == *"x86_64"* ]] && [[ $i != *"exadata"* ]] && [[ $i != *"spacewalk"* ]]; then # Define what to include (==) / exclude (!=) here
        CHANNEL_LIST+=" -c ${i} -a"
    fi
done
uln-channel -u ${USERNAME} -p ${PASSWORD} $CHANNEL_LIST
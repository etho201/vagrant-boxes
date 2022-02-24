FROM centos:7
LABEL maintainer="Erik Thomsen"

# Remove existing repo files
RUN mkdir -p /etc/yum.repos.d/bkup/ && mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bkup/

# Create repo file that points to OLM repository
COPY olm-centos-epel7.repo /etc/yum.repos.d/olm-centos-epel7.repo
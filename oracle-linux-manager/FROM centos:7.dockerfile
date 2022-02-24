FROM centos:7
LABEL maintainer="Erik Thomsen"

# Remove existing repo files
RUN mkdir -p /etc/yum.repos.d/bkup/ ** mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bkup/

# Create repo file that points to OLM repository
RUN cat <<'EOF' > /etc/yum.repos.d/olm-demo.repo
[olm_demo]
name=OLM Demo
baseurl=http://192.168.56.10/pub/1/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1
EOF

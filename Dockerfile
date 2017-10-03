FROM fedora:24

# Postfix image for OpenShift.
#
# Volumes:
#  * /var/spool/postfix -
#  * /var/spool/mail -
#  * /var/log/postfix - Postfix log directory
# Environment:
#  * $MYHOSTNAME - Hostname for Postfix image
# Additional packages
#  * findutils are needed in case fedora:24 is loaded from docker.io.

RUN dnf install -y --setopt=tsflags=nodocs postfix openssl-libs findutils && \
    dnf -y clean all

MAINTAINER "Petr Hracek" <phracek@redhat.com>

ENV POSTFIX_SMTP_PORT=10025

ADD files /files

RUN /files/postfix_config_tls.sh

EXPOSE 10025

# Postfix UID based from Fedora
# USER 89

VOLUME ["/var/spool/postfix"]
VOLUME ["/var/spool/mail"]
VOLUME ["/var/log"]
VOLUME ["/var/certs"]

ADD mail.txt /tmp/mail.txt
ADD test.py /tmp/mail.py
RUN postfix start && sleep 4 && python3 /tmp/mail.py && postqueue -f && sleep 15 && postqueue -p && cat /var/log/*

CMD ["/files/start_tls.sh"]

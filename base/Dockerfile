#
# mdq-server base dockerfile
#
FROM ianayoung/mdq-server:latest

MAINTAINER Ian Young <ian@iay.org.uk>

#
# VOLS_BASE is where we mount volumes. This is outside the application
# proper for backwards compatibility.
#
ENV VOLS_BASE=/opt/mdq-server

#
# MDQ_HOME is where the application's resources live.
#
ENV MDQ_HOME=/workspace/BOOT-INF/classes

EXPOSE 8080

ENV CREDS_DIR=${VOLS_BASE}/creds
ENV LOGS_DIR=${VOLS_BASE}/logs
VOLUME ["${LOGS_DIR}", "${CREDS_DIR}"]

WORKDIR ${MDQ_HOME}

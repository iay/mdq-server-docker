#
# iay/mdq-server-static dockerfile
#
FROM ianayoung/mdq-server:latest

LABEL maintainer="Ian Young <ian@iay.org.uk>"

#
# VOLS_BASE is where we mount volumes. This is outside the application
# proper for backwards compatibility.
#
ENV VOLS_BASE=/opt/mdq-server

#
# MDQ_HOME is where the application's resources live. This is determined by
# the buildpack used in the parent container.
#
ENV MDQ_HOME=/application/BOOT-INF/classes

#
# The parent container was built by the Spring Boot Maven plugin, which
# uses buildpacks and defaults to running under `USER 1000:1000`.
#
# We need to adjust that and run under root so that we can place the mounted
# volumes outside the area accessible by user 1000.
#
USER root

#
# Assume that each configuration be set up to bind to port 80.
#
EXPOSE 80

ENV LOGS_DIR=${VOLS_BASE}/logs
VOLUME ${LOGS_DIR}

WORKDIR ${MDQ_HOME}

ADD resources ${MDQ_HOME}/

WORKDIR /application
#
# End.
#

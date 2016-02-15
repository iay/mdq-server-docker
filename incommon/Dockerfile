#
# iay/mdq-server-incommon dockerfile
#
FROM iay/mdq-server-base

MAINTAINER Ian Young <ian@iay.org.uk>

WORKDIR /opt/mdq-server

ADD resources                     /opt/mdq-server/

# Override the CMD to set the heap size.
CMD ["java", "-Xmx1024M", "-jar", "mdq-server.jar"]

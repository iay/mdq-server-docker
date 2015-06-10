#
# iay/mdq-server-incommon dockerfile
#
FROM iay/mdq-server-base

MAINTAINER Ian Young <ian@iay.org.uk>

WORKDIR /opt/mdq-server

ADD resources                     /opt/mdq-server/

CMD ["java", "-Xmx1024M", "-jar", "mdq-server-0.0.1-SNAPSHOT.jar"]

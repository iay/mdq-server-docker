# `mdq-server-base`

## `mdq-server` Deployment Base Container

This [Docker](http://www.docker.com) image acts as a base for
specific deployments.

It is in turn based on the [OpenJDK](http://openjdk.java.net) 8 variant of the
official Docker library [Java image](https://registry.hub.docker.com/_/java/).

To build the base image:

    $ ./build

This will:

* Pull the latest version of the Java library image.
* Acquire the `.jar` artifact containing the web application bundled
with an appropriate application container (usually Jetty).
* Build the Docker image and tag it as `mdq-server-base`.


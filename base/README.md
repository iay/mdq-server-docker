# `iay/mdq-server-base`

## `mdq-server` Deployment Base Container

This [Docker][] image acts as a base for specific deployments.

It is in turn based on the container built by the [mdq-server][] project
([ianayoung/mdq-server][]), which:

* Uses a Java 11 runtime,
* Is built by the Spring Boot Maven plugin using buildpacks,
* Binds by default to port 8080,
* Runs by default under `USER 1000:1000`.

We adjust this to running under the root user, and binding to port 80 instead,
for compatibility with previous deployments.

To build the base image and tag it as `iay/mdq-server-base:latest`:

    $ ./build

[Docker]: https://www.docker.com/
[mdq-server]: https://github.com/iay/mdq-server
[ianayoung/mdq-server]: https://hub.docker.com/repository/docker/ianayoung/mdq-server

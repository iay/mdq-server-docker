# `iay/mdq-server-static`

## `mdq-server` Static Deployment

This Docker image deploys the
[`mdq-server`](https://github.com/iay/mdq-server) web application
to serve up entity metadata from a fixed four-entity aggregate.
The intended application is as a test target for Shibboleth
unit tests.

Deployment is via a [Docker](http://www.docker.com) container built
on top of the `iay/mdq-server-base` image built using the recipe in the
sibling `base` directory.

## Configuration and Build

Configuration of the application is performed by modifying the files
in `resources/`, in particular the `config.xml` and `config/application.properties`
files. These assume the baseline configuration from the upstream
[`mdq-server`](https://github.com/iay/mdq-server) project.

If you don't want to sign the resulting metadata responses at all,
change `spring.profiles.active` to exclude the `sign` profile.

The `server.servlet.context-path` property may need to be changed depending on
the kind of proxy you are using. In my case, I'm using
[`nginx`](http://nginx.org/en/) which has some
[odd but by-design behaviour](http://trac.nginx.org/nginx/ticket/262) when
passing through URL-encoded path components. In my case, this can be fixed
by passing the whole URI path through but it means that the application
context has to be set to '/static'.

If you want to use signing credentials of your own, create a directory
called `creds` inside the repository and put the private key and
certificate in there. This directory will be mounted as a volume inside
the Docker container, and is `.gitignore`d, so you don't need to worry
about those credentials being saved somewhere you don't want them to be.

The default names for the credential files are `signing.key` and
`signing.crt`. If you want to use other names for some reason, change
`application.properties` accordingly.

If you want to sign responses but don't have existing credentials you
want to use, just execute the `./keygen` script once. This will create a
`creds` directory and populate it with a 2048-bit private key and a
corresponding 10-year self-signed certificate.

To build the image, execute the `./build` script. This will tag the
resulting image as `iay/mdq-server-static`, but won't push it anywhere.

## Simple Container Operation

The script `./run` is provided to fire up a copy of the `iay/mdq-server-static`
image in a new container called `mdq-server-static`.

The `./run` script binds a couple of local directories as volumes
connected to the container:

* The `creds` directory, `/opt/mdq-server/creds` in the container,
  is the volume the application pulls its credentials from.

* The `logs` directory, `/opt/mdq-server/logs` in the container,
  is the volume the application logs into. The log file is called
  `spring.log` by default.

Because they are mounted as volumes, the contents of these two directories
persist between container invocations.

By default, the `./run` script does *not* map a host port for the container,
under the assumption that the deployment will be behind some kind of proxy.
Uncomment the definition of `MAP_PORT` if you need to map a host port.

The `./stop` script stops the container.

The `./terminate` script stops the container *and then removes it.*

## Testing

You can run the deployment directly using the `./test` script in
order to test the configuration.

In this case, the container runs with output visible on the console, and
with the container's port mapped to the host's port 8080 by default.

You can hit Ctrl+C to stop (and terminate) the test container.

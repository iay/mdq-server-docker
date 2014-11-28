# `mdq-server-incommon`

## `mdq-server` Proof of Concept Deployment

This project is a proof of concept deployment of the
[`mdq-server`](https://github.com/iay/mdq-server) web application
customised to serve up Identity Provider metadata from the
[InCommon Federation](https://incommon.org).

Deployment is via a [Docker](http://www.docker.com) container built
on top of the `mdq-server-base` image built using the recipe in the
sibling `base` directory.

## Configuration and Build

Configuration of the application is performed through modifying the files
in `resources/`, in particular the `config.xml` and `application.properties`
files. These assume the baseline configuration from the upstream
[`mdq-server`](https://github.com/iay/mdq-server) project.

Note that a second `application.properties` file appears in the main directory;
its purpose is to set alternative configuration for use by the `./test` script.

If you don't want to sign the resulting metadata responses at all,
change `spring.profiles.active` to exclude the `sign` profile.

The `server.context-path` property may need to be changed depending on
the kind of proxy you are using. In my case, I'm using
[`nginx`](http://nginx.org/en/) which has some
[odd but by-design behaviour](http://trac.nginx.org/nginx/ticket/262) when
passing through URL-encoded path components. In my case, this can be fixed
by passing the whole URI path through but it means that the application
context has to be set to '/incommon'.

By default, the web application is exposed on the container's port 80, the standard
port for HTTP. To change this, you need to change the `server.port` in
`application.properties` and the `EXPOSE` line in `Dockerfile`. It's usually
better to take care of this in the `docker run` command, though.

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

Before attempting to build the image for the Docker container, you
need to acquire a copy of `mdq-server-0.0.1-SNAPSHOT.jar` by
running `mvn -Prelease clean package` on a copy of the `mdq-server`
project.

To build the image, execute the `./build` script. This will tag the
resulting image as `mdq-server-incommon`, but won't save it anywhere.

## Simple Container Operation

The script `./run` is provided to fire up a copy of the `mdq-server-incommon`
image in a new container also called `mdq-server-incommon`. At present, this
is set up to leave your terminal connected to the container so that
you will see the initial logging as the application starts up. You
can hit Ctrl+C when you've seen enough: you don't need to worry about
subsequent console logging blocking anything (it's thrown away until
you use `docker attach` on the container) or being lost
(the application is also logging into a file which is visible
outside the container in directory mounted as a container volume).

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

The `./cleanup` script can be used at any time to remove orphaned
containers and images, which Docker tends to create in abundance during
development. Use `./cleanup -n` to "dry run" and see what it would remove.

## Testing

You can run the `mdq-server` deployment directly using the `./test` script in
order to test the configuration in an environment that does not have
Docker available.

In this case, the copy of `application.properties` in the project home directory
is used rather than the copy from `resources/`. This makes use of a local `creds`
directory outside the `resources` directory, as generated by `./keygen`.

The test configuration binds to port 8080 and uses a context path of "`/`".

## Service Integration

The `service` directory contains scripts for host operating system service integration.

### `upstart` Integration

`service/mdq-server-ncommon.conf` is for `upstart`-based systems such as Ubuntu 14.04 LTS.
To work round a [known problem in Docker](https://github.com/docker/docker/issues/6647),
it makes use of the `inotifywait` command from the `inotify-tools` package, which may
not already be installed.

Install the service configuration as follows:

    # apt-get install inotify-tools
    # cp service/mdq-server-incommon.conf /etc/init
    # initctl start mdq-server-incommon

### `systemd` Integration

`service/mdq-server-incommon` is for `systemd`-based systems. It is at present untested.


# `mdq-server-incommon`

## `mdq-server` Proof of Concept Deployment

This project is a proof of concept deployment of the
[`mdq-server`](https://github.com/iay/mdq-server) web application
customised to serve up Identity Provider metadata from the
[InCommon Federation](https://incommon.org).

Deployment is via a [Docker](http://www.docker.com) container built
from the library [Java image](https://registry.hub.docker.com/_/java/).

## Configuration and Build

Configuration of the application is partly performed in the upstream
[`mdq-server`](https://github.com/iay/mdq-server) and partly through
properties set in the `application.properties` file.

If you don't want to sign the resulting metadata responses at all,
change `spring.profiles.active` to exclude the `sign` profile.

The `server.context-path` property may need to be changed depending on
the kind of proxy you are using. In my case, I'm using
[`nginx`](http://nginx.org/en/) which has some
[odd but by-design behaviour](http://trac.nginx.org/nginx/ticket/262) when
passing through URL-encoded path components. In my case, this can be fixed
by passing the whole URI path through but it means that the application
context has to be set to '/incommon'.

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
resulting image as `mdq_incommon`, but won't save it anywhere.

## Container Operation

The script `./run` is provided to fire up a copy of the `mdq_incommon`
image in a new container also called `mdq_incommon`. At present, this
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

The `./stop` script stops the container and then removes it.

The `./cleanup` script can be used at any time to remove orphaned
containers and images, which Docker tends to create in abundance during
development. Use `./cleanup -n` to "dry run" and see what it would remove.

## Copyright and License

The entire package is Copyright (C) 2014, Ian A. Young.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

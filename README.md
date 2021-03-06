# `mdq-server-docker`

## `mdq-server` Deployment Using Docker

This project builds [Docker](http://www.docker.com) images allowing
deployment of the
[`mdq-server`](https://github.com/iay/mdq-server) web application
customised to serve up SAML metadata from various sources.

The following directories contain Docker recipes for specific
deployments:

* [`incommon`](incommon/) is a deployment configured to
serve up metadata from the
[InCommon Federation](https://incommon.org) and the
[eduGAIN](http://www.edugain.org) inter-federation metadata exchange service.

* [`static`](static/) serves up metadata sourced from a static
metadata aggregate. The intended use is as a test target for
Shibboleth unit tests.

* [`ukf`](ukf/) sources metadata from the
[UK Access Management Federation](http://ukfederation.org.uk/)'s
production metadata aggregate.

Each deployment is built on top of the `iay/mdq-server-base` image,
which factors out a lot of common configuration. The recipe for
the `iay/mdq-server-base` image can be found in the [`base`](base/) directory.
You should build the base image before building any of the
deployment images.

**Note:** The individual `run` scripts for the above deployments are
customised for use on my own staging server. In this environment, the
various `mdq-server-*` containers are placed behind an `nginx` proxy
in a Docker network called `nginx-109` rather than being directly exposed.
You will almost certainly need to change these scripts for your own
deployment.

The `./cleanup` script can be used at any time to remove orphaned
containers and images, which Docker tends to create in abundance during
development. Use `./cleanup -n` to "dry run" and see what it would remove.

## Copyright and License

The entire package is Copyright (C) 2014&ndash;2016, Ian A. Young.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

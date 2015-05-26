# Tomcat with inspectIT
Tomcat Dockerfile including inspectIT

This docker image is based on the official Tomcat docker image including the inspectIT agent of the open source APM solution [www.inspectit.eu](http://www.inspectit.eu).
This image can be used easily as a replacement for the Tomcat image, meaning you only have to change your existing Dockerfile ```FROM tomcat:latest``` to ```FROM inspectit/tomcat:latest```.

## Quickstart
First you need a running inspectIT CMR. You can use our docker image:

```bash
$ docker run -d --name inspectIT-CMR -p 8182:8182 -p 9070:9070 inspectit/cmr
```

Now you can start a container with the following command:

```bash
$ docker run -d --link inspectIT-CMR:cmr -h inspectit/tomcat -v $(pwd)/config:/opt/agent/active-config inspectit/tomcat
```

You can now adjust the instrumentation configuration in the folder *config* for your needs. Please refer to our [documentation](https://documentation.novatec-gmbh.de/display/INSPECTIT/Agent+Configuration) or just leave a comment.

FROM tomcat
MAINTAINER info.inspectit@novatec-gmbh.de

#set Workdir
WORKDIR /opt

#set insepctit env
ENV INSPECTIT_VERSION 1.6.6.76
ENV INSPECTIT_AGENT_HOME /opt/agent
ENV INSPECTIT_CONFIG_HOME /opt/agent/active-config

# get inspectit binary
# set inspectit jvm options
RUN wget --no-check-certificate https://github.com/inspectIT/inspectIT/releases/download/${INSPECTIT_VERSION}/inspectit-agent-sun1.5.zip \
&& unzip inspectit-agent-sun1.5.zip \
&& rm -f inspectit-agent-sun1.5.zip \
&& sed -i '250i\'"export INSPECTIT_JAVA_OPTS=\"-Xbootclasspath/p:${INSPECTIT_AGENT_HOME}/inspectit-agent.jar -javaagent:${INSPECTIT_AGENT_HOME}/inspectit-agent.jar -Dinspectit.config=${INSPECTIT_CONFIG_HOME}\"" /usr/local/tomcat/bin/catalina.sh \
&& sed -i '251i\'"export JAVA_OPTS=\"\${INSPECTIT_JAVA_OPTS} \${JAVA_OPTS}\"" /usr/local/tomcat/bin/catalina.sh

#copy start script
COPY run-with-inspectit.sh /run-with-inspectit.sh

#define VOLUME for active agent config
VOLUME ["/opt/agent/active-config"]

# define default command
CMD ["/run-with-inspectit.sh", "run"]

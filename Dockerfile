# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
 
RUN mkdir /etc/docker
ADD ./.dockercfg /root/.dockercfg
RUN chmod 400 /root/.dockercfg
# Install Docker from Docker Inc. repositories.
RUN apt-get install -y docker-engine=1.10.5-0~trusty
# Install the magic wrapper
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker
 
# Define additional metadata for our image.
VOLUME /var/lib/docker
# Considering /jenkins is your FS root on the mesos slave settings on Jenkins
VOLUME /jenkins/workspace
CMD ["wrapdocker"]

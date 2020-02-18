FROM stilliard/pure-ftpd

# install dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && \
	apt-get --no-install-recommends --yes install \
	openssh-server

# change home dir
RUN usermod -d /home ftpuser

# setup run/init file
COPY run.sh /run.sh
RUN chmod u+x /run.sh

# default publichost, you'll need to set this for passive support
ENV PUBLICHOST localhost

# couple available volumes you may want to use
VOLUME ["/home", "/etc/pure-ftpd/passwd"]

# startup
CMD /run.sh -l unix -E -j -R -P $PUBLICHOST

EXPOSE 21 22 30000-30009

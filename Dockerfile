FROM steamcmd/steamcmd:ubuntu-24

# Some dependencies to download.
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y libcurl3-gnutls wget && \
	wget http://security.ubuntu.com/ubuntu/pool/universe/n/ncurses/libtinfo5_6.3-2ubuntu0.1_amd64.deb http://security.ubuntu.com/ubuntu/pool/universe/n/ncurses/libncurses5_6.3-2ubuntu0.1_amd64.deb && \
	apt-get install -y ./libtinfo5_6.3-2ubuntu0.1_amd64.deb ./libncurses5_6.3-2ubuntu0.1_amd64.deb

# Copy all the important scripts in.
WORKDIR /root/.steam/svscripts
ADD ./scripts/* ./
WORKDIR /root/.steam/sv

# Set the entrypoint to be the run.sh script.
ENTRYPOINT [ "/root/.steam/svscripts/run.sh" ]
CMD [ "-exec", "autoexec" ]

# Expose the SRCDS port. Purely for the -P cli argument.
# People who run the container will still need to route the port themselves.
EXPOSE 27005/tcp
EXPOSE 27005/udp
EXPOSE 27015/tcp
EXPOSE 27015/udp

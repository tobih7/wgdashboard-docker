FROM linuxserver/wireguard:latest

# install dependencies
RUN apk add python3 python3-dev gcc g++ make libffi-dev jq
RUN python3 -m ensurepip

# download wgdashboard
RUN curl -sLo /tmp/wgdashboard.tar.gz $(curl -s https://api.github.com/repos/donaldzou/WGDashboard/releases/latest | jq -r '.tarball_url')
RUN tar xf /tmp/wgdashboard.tar.gz
RUN mv $(tar tf /tmp/wgdashboard.tar.gz | head -1 | cut -d '/' -f 1) /wgdashboard

# install wgdashboard
WORKDIR /wgdashboard/src
RUN chmod u+x wgd.sh
RUN ./wgd.sh install

# clean up
RUN rm -rf /tmp

COPY /root /
WORKDIR /

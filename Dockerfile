FROM tigrlab/fmriprep_ciftify:1.1.8-2.1.1

LABEL maintainer="Monica Li <monica.li@uconn.edu>"

# bash prompt
RUN cat /etc/bash.bashrc | sed -E "s/PS1=(.*):(.*)/PS1=\1(fmriprep_ciftify):\2/" > /tmp/tmp.bashrc && \
mv /tmp/tmp.bashrc /etc/bash.bashrc
RUN cat $HOME/.bashrc | sed -E "s/PS1=(.*):(.*)/PS1=\1(fmriprep_ciftify):\2/" > /tmp/tmp.bashrc && \
mv /tmp/tmp.bashrc $HOME/.bashrc

# configure PATH
ENV PATH=$PATH:/home/code/ciftify/ciftify/bidsapp

# setup singularity compatible entry points to run the initialization script
RUN mkdir /scratch

RUN /usr/bin/env \
| sed  '/^HOME/d' \
| sed '/^HOSTNAME/d' \
| sed  '/^USER/d' \
| sed '/^PWD/d' > /environment && \
chmod 755 /environment

COPY entry_init.sh /singularity
RUN chmod 755 /singularity

ENTRYPOINT ["/singularity"]

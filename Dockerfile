FROM tigrlab/fmriprep_ciftify:1.1.8-2.1.1

# setup singularity compatible entry points to run the initialization script
RUN /usr/bin/env \
| sed  '/^HOME/d' \
| sed '/^HOSTNAME/d' \
| sed  '/^USER/d' \
| sed '/^PWD/d' > /environment && \
chmod 755 /environment

COPY entry_init.sh /singularity
RUN chmod 755 /singularity

ENTRYPOINT ["/singularity"]
CMD ["/bin/bash"]

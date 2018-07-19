FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install bzip2 \
        curl \
        default-jdk \
        bzip2 \
        wget -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY cplex_studio128.linux-x86-64.bin /root
COPY installer.properties /root

RUN wget https://repo.continuum.io/miniconda/Miniconda3-4.4.10-Linux-x86_64.sh \
    && chmod +x Miniconda3-4.4.10-Linux-x86_64.sh \
    && bash Miniconda3-4.4.10-Linux-x86_64.sh -b -p /opt/miniconda \
    && rm Miniconda3-4.4.10-Linux-x86_64.sh \
    && chmod a+x /root/cplex_studio128.linux-x86-64.bin \
    && /root/cplex_studio128.linux-x86-64.bin -f installer.properties -i silent \
    && rm /root/cplex_studio128.linux-x86-64.bin \
    && cd /opt/ibm/ILOG/CPLEX_Studio128/cplex/python/3.6/x86-64_linux \
    && /opt/miniconda/bin/python3 setup.py install \
    && /opt/miniconda/bin/conda install jupyter ipython matplotlib pandas -y \
    && rm -rf /root/*

# ipython/jupyter configurations
EXPOSE 8888

WORKDIR /root
CMD /opt/miniconda/bin/jupyter notebook --ip=0.0.0.0 --allow-root

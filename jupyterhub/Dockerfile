FROM jupyterhub/jupyterhub
MAINTAINER Timothy Hnat twhnat@memphis.edu

# RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list && \
#     apt-get -yqq update && \
#     apt-get install -t jessie-backports -yqq openjdk-8-jre python3-setuptools libyaml-dev libev-dev liblapack-dev && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/* && \
#     rm -rf /tmp/*

RUN apt-get -yqq update && \
    apt-get install -yqq openjdk-8-jre python3-setuptools libyaml-dev libev-dev liblapack-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*


# Spark dependencies
ENV APACHE_SPARK_VERSION 2.3.2
ENV HADOOP_VERSION 2.7

RUN easy_install pip==9.0.3
# RUN pip install --upgrade pip
RUN pip3 install wheel
RUN pip3 install minio==2.2.4
RUN pip3 install pytz==2017.2
RUN pip3 install PyYAML==3.12
RUN pip3 install pyarrow==0.8.0
RUN pip3 install kafka
RUN pip3 install influxdb==5.0.0
RUN pip3 install pympler
RUN pip3 install scipy
RUN pip3 install numpy

RUN cd /tmp && \
        wget -q http://apache.cs.utah.edu/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
        tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/local && \
        rm spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark

ENV SPARK_HOME  /usr/local/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info
ENV JAVA_HOME   /usr/lib/jvm/java-8-openjre-amd64
ENV PYSPARK_PYTHON /opt/conda/bin/python3
ENV PATH        $JAVA_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH

# Install Cerebral Cortex libraries for use in the notebook environment
RUN git clone https://github.com/MD2Korg/CerebralCortex -b 2.2.2 \
    && cd CerebralCortex \
    && sed -i '/cassandra-driver==3.12.0/d' requirements.txt  \
    && python3 setup.py install \
    && cd .. && rm -rf CerebralCortex


RUN pip install --upgrade jupyterhub
RUN pip install jupyter

RUN mkdir /opt/conda/share/jupyter/kernels/pyspark
COPY pyspark/kernel.json /opt/conda/share/jupyter/kernels/pyspark/

RUN useradd -m md2k && echo "md2k:md2k" | chpasswd

RUN pip3 install matplotlib
VOLUME /srv/jupyterhub/conf

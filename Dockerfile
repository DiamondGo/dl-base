FROM flowerseems/debian-base

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 build-essential git
RUN wget https://repo.continuum.io/archive -O - 2>/dev/null | grep Anaconda3 | grep x86_64 | head -1 | awk -F '"' '{print $2}' |{ read uri; wget "https://repo.continuum.io/archive/${uri}" -O ~/anaconda3.sh -c -t 0; }
RUN /bin/bash ~/anaconda3.sh -b -p /opt/conda
RUN rm -f ~/anaconda3.sh

# notebook
RUN /opt/conda/bin/conda install jupyter -y --quiet

# theano
RUN /opt/conda/bin/conda install theano -y --quiet
RUN mkdir /opt/notebooks

# tensorflow
RUN /opt/conda/bin/conda create -y -n tensorflow
RUN echo "#!/bin/bash" >> ~/tf.sh
RUN echo "source activate tensorflow" >> ~/tf.sh
RUN echo "pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.3.0-cp36-cp36m-linux_x86_64.whl" >> ~/tf.sh
RUN chmod +x ~/tf.sh
RUN ["/bin/bash", "~/tf.sh"] 
RUN rm -f ~/tf.sh
#RUN source activate tensorflow && pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.3.0-cp36-cp36m-linux_x86_64.whl


RUN apt-get purge --auto-remove -y wget
RUN rm -rf /var/cache/apk/*

ENV PATH /opt/conda/bin:$PATH

CMD /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser --allow-root


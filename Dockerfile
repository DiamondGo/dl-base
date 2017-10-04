FROM flowerseems/debian-base

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && apt-get install -y wget bzip2
RUN wget https://repo.continuum.io/archive -O - 2>/dev/null | grep Anaconda3 | grep x86_64 | head -1 | awk -F '"' '{print $2}' |{ read uri; wget "https://repo.continuum.io/archive/${uri}" -O ~/anaconda3.sh -c -t 0; }
RUN /bin/bash ~/anaconda3.sh -b -p /opt/conda
RUN rm -f ~/anaconda3.sh

RUN /opt/conda/bin/conda install jupyter -y --quiet
RUN /opt/conda/bin/conda install theano -y --quiet
RUN mkdir /opt/notebooks

ENV PATH /opt/conda/bin:$PATH

CMD /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser --allow-root


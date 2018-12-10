FROM julia:0.7.0-stretch

MAINTAINER weecology "https://github.com/weecology/Retriever.jl"

# Install Python3 and Retriever
RUN apt-get update
RUN apt-get install -y --force-yes build-essential wget git locales locales-all

# Set encoding
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get remove -y python && apt-get install -y python3  python3-pip curl postgresql-client
# r-base
RUN rm -f /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python
RUN rm -f /usr/bin/pip && ln -s /usr/bin/pip3 /usr/bin/pip

RUN echo "export PATH="/usr/bin/python:$PATH"" >> ~/.profile
RUN echo "export PYTHONPATH="/usr/bin/python:$PYTHONPATH"" >> ~/.profile
# RUN echo "export PGPASSFILE="cli_tools/.pgpass"" >> ~/.profile
RUN echo "export PGPASSFILE="~/.pgpass"" >> ~/.profile

RUN chmod 0644 ~/.profile
 
# RUN "export PATH=\"/usr/bin/python:$PATH"
RUN pip install git+https://git@github.com/weecology/retriever.git  && retriever ls
RUN pip install  psycopg2 pymysql
# installing julia from repo
# RUN add-apt-repository -y ppa:staticfloat/juliareleases ppa:staticfloat/julia-deps
# RUN apt-get -yq update &>> ~/apt-get-update.log
# RUN apt-get install libgmp3-dev apt-get install julia
COPY . /Retriever.jl

RUN chmod 0755 /Retriever.jl/cli_tools/entrypoint.sh
ENTRYPOINT ["/Retriever.jl/cli_tools/entrypoint.sh"]

WORKDIR /Retriever.jl

#https://gist.github.com/md5/7793ee806183b1c846be
RUN julia -e 'using InteractiveUtils; versioninfo()'
RUN julia -e 'using Pkg;Pkg.update()'
RUN julia -e 'using Pkg; Pkg.add("PyCall")'
RUN echo $PYTHON
RUN echo $JULIA_LOAD_PATH
RUN export PGPASSFILE="~/.pgpass"
RUN chmod 600 cli_tools/.pgpass
RUN chmod 600 cli_tools/.my.cnf

# CMD ["bash", "-c", "julia", "cd Retriever.jl && julia test/runtests.jl"]
CMD ["bash", "-c", "julia test/runtests.jl"]
# julia test/runtests.jl
# docker exec -i  [newrd5] bash -c "cd Retriever.jl && julia test/runtests.jl"
# docker exec -i  testj1 bash -c "cd Retriever.jl && julia test/runtests.jl"
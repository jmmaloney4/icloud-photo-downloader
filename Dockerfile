FROM ubuntu:focal@sha256:b3e2e47d016c08b3396b5ebe06ab0b711c34e7f37b98c9d37abe794b71cea0a2
RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install python3 python3-pip \
    && apt-get -y autoremove
RUN pip3 install pipenv
RUN mkdir -p code
WORKDIR code
COPY Pipfile .
RUN pipenv install
COPY . .
CMD ["pipenv", "run", "./download.py"]

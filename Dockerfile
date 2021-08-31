FROM ubuntu:focal@sha256:9d6a8699fb5c9c39cf08a0871bd6219f0400981c570894cd8cbea30d3424a31f
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

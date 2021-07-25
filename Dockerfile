FROM ubuntu:focal@sha256:778fdd9f62a6d7c0e53a97489ab3db17738bc5c1acf09a18738a2a674025eae6
RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install python3 python3-pip \
    && apt-get -y autoremove
RUN pip3 install pipenv
RUN mkdir -p code
WORKDIR code
COPY Pipfile .
RUN pipenv install
COPY . .
CMD ["pipenv", "run", "./back.py"]

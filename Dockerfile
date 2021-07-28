FROM ubuntu:focal@sha256:82becede498899ec668628e7cb0ad87b6e1c371cb8a1e597d83a47fac21d6af3
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

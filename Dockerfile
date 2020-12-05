FROM  jenkins/jenkins:lts

USER root
RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    libcppunit-dev \
    cmake \
    build-essential \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    virtualenv

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"

RUN apt-get update && apt-get install -y docker-ce python-pip

RUN pip install pytest
RUN apt-get install -y sudo

RUN echo jenkins:jenkins | chpasswd

RUN  usermod -aG sudo jenkins
RUN  usermod -aG docker jenkins

RUN systemctl enable docker

USER jenkins

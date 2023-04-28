FROM openjdk:17-slim

ENV TERRAFORM_VERSION=1.1.7
ARG TERRAFORM_VERSION=$TERRAFORM_VERSION

RUN apt update

## Install CURL
RUN apt install curl -y

## Install Git:
RUN apt install git -y

## Install zip
RUN apt install zip -y

## Install Terraform
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv
RUN echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
RUN ln -s ~/.tfenv/bin/* /usr/local/bin
RUN tfenv install $TERRAFORM_VERSION
RUN tfenv use $TERRAFORM_VERSION

VOLUME /tmp
COPY target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
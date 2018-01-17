FROM node:7.7.2-alpine

# Update date to rebuild cached image
ENV REFRESHED_AT 2017-03-14

# File Author / Maintainer
MAINTAINER Jeff Deskins

RUN mkdir /src

WORKDIR /src

# Provides cached layer for node_modules
COPY package.json /src/package.json
RUN npm install

COPY . /src

EXPOSE  8080

# Run app
CMD ["node", "index.js"]

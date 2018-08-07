FROM node:10-alpine

ARG SOURCE_COMMIT
ENV SOURCE_COMMIT ${SOURCE_COMMIT}
ARG DOCKER_TAG
ENV DOCKER_TAG ${DOCKER_TAG}

ENV NPM_CONFIG_LOGLEVEL warn

RUN apk add --no-cache make bash ca-certificates sed git nano

RUN npm config set unsafe-perm true
RUN npm i npm@latest -g
RUN npm install -g yarn

WORKDIR /var/app
RUN mkdir -p /var/app


COPY package.json yarn.lock /var/app/
RUN yarn install --non-interactive --frozen-lockfile

COPY . /var/app

ENV PORT 3000

EXPOSE 3000

#ENTRYPOINT ["echo","node get-claimed-rewards.js username"]
#CMD ["/bin/sh"]

CMD [ "node", "frontrun.js" ]

FROM node

WORKDIR /usr/src/app/
COPY package*.json ./
RUN npm install

COPY src .

ENTRYPOINT ["node"]
CMD ["server"]
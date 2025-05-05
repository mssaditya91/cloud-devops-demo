FROM node:{{ node_version }}-alpine
WORKDIR /app
COPY package.json .
RUN npm install
COPY server.js .
EXPOSE {{ backend_port }}
CMD ["node", "server.js"]

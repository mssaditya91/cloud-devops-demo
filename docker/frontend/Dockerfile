FROM node:{{ node_version }}-alpine AS build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:{{ nginx_version }}-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE {{ frontend_port }}
CMD ["nginx", "-g", "daemon off;"]

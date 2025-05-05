FROM nginx:{{ nginx_version }}-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN apk add --no-cache curl
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost/ || exit 1
EXPOSE {{ nginx_port }}

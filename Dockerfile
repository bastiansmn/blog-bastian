FROM hugomods/hugo:exts AS builder

WORKDIR /app

COPY . .

RUN npm install

RUN npm run build


FROM bitnami/nginx:latest

WORKDIR /app

COPY --from=builder /app/public /app

COPY nginx.conf /opt/bitnami/nginx/conf/server_blocks/default-server-block.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]

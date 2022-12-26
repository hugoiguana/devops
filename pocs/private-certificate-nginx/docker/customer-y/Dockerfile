FROM nginx:alpine

RUN mkdir -p /etc/nginx/external

COPY certs/customerx.pem /etc/nginx/external/customerx.pem
COPY certs/customerx.crt /etc/nginx/external/customerx.crt
COPY certs/customerxCA.pem /etc/nginx/external/customerxCA.pem

COPY certs/customery.pem /etc/nginx/external/customery.pem
COPY certs/customery.crt /etc/nginx/external/customery.crt
COPY certs/customeryCA.pem /etc/nginx/external/customeryCA.pem

COPY nginx.conf /etc/nginx/nginx.conf
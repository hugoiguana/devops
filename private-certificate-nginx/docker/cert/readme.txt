openssl genrsa -passout pass:"test" -des3 -out cert/matrixCA.key 2048

openssl req -passin pass:"test" -subj "/C=US/ST=Random/L=Random/O=Global Security/OU=IT Department/CN=Private Certificate" -x509 -new -nodes -key cert/matrixCA.key -sha256 -days 1024 -out cert/matrixCA.pem

openssl req -subj "/C=US/ST=Random/L=Random/O=Global Security/OU=IT Department/CN=matrix" -new -sha256 -nodes -out cert/matrix.csr -newkey rsa:2048 -keyout cert/matrix.pem
openssl x509 -req -passin pass:"test" -in cert/matrix.csr -CA cert/matrixCA.pem -CAkey cert/matrixCA.key -CAcreateserial -out cert/matrix.crt -days 500 -sha256 -extfile cert/domains.txt

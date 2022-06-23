
## Configuration on Linux

1. Add "devops.infra" domain to your hosts:
   ```sh
   echo '127.0.0.1 devops.infra' | sudo tee -a /etc/hosts
   cat /etc/hosts
   ```
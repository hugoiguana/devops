

<!-- INSTALATION -->
## Instalation on Linux

1. Visit the documentation:
   ```sh
   https://kind.sigs.k8s.io/docs/user/quick-start/
   ```
2. Installing From Release Binaries:
```sh
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.12.0/kind-linux-amd64
chmod +x ./kind
mv ./kind ~/kind
```
3. Add kind to the Path. Open the "~/.bashrc" file and add:
```sh
KIND_HOME=/home/hugo/kind
export KIND_HOME
export PATH=$PATH:$KIND_HOME
```
4. Close your terminal and open it again and test with the command:
```sh
kind --help
```

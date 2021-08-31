# docker-dind-sshd

1. docker image: [dockerhub](https://hub.docker.com/r/wangz2019/docker-dind-sshd)
2. source code: [github](https://github.com/ben-wangz/docker-dind-sshd)
3. docs: [docker-dind-sshd-docs](https://ben-wangz.github.io/docker-dind-sshd/index.html)

## what's it

1. docker image of dind bind with sshd
2. mainly used for testing environment construction

## usage

1. start service
    * build docker image
        + optional
        + ```shell
          ./gradlew :buildDockerImage
          ```
    * run docker container
        + ```shell
          ./gradlew :runDockerContainer
          ```
        + ssh service will be exposed with port 1022
    * jump into container with ssh
        + ```shell
          ssh -o "UserKnownHostsFile /dev/null" -p 1022 root@localhost
          ```
    * use docker client to connect to docker service
        + ```shell
          docker -H tcp://localhost:12375 run hello-world:linux
          ```
2. stop service
    * ```shell
      ./gradlew :stopDockerContainer
      ```
3. build multi-platform images and push them to docker registry
    * ```shell
      ./gradlew :pushDockerImage
      ```

* you need an environment to build multi-platform
  images: [develop with docker](https://blog.geekcity.tech/#/docs/develop.with.docker)

## configuration

* AUTHORIZED_KEYS
    + configuring authorized_keys for openssh
    + needs public key content
    + not the path to public key(s)
* DOCKER_TLS_CERTDIR
    + switch ssl on/off
    + port will be changed: on -> 2376; off -> 2375
* DOCKER_CONFIG_JSON
    + a json value
    + the value will be written into `/root/.docker/config.json`(the client configuration)
* more configurations: [docker(dind) official docs](https://hub.docker.com/_/docker/)

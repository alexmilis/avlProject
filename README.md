# avlProject

Run the docker compose with following:
```
sudo docker-compose up
```

To run individual images, first build image and then run with exposing port.
```
sudo docker run -p hostPort:dockerPort imageID
```

To send a request to service use:
```
curl -d "data" 'http://127.0.0.1:hostPort'
```

After running the docker compose, an example of valid request and response are:
```
curl -d "http://google.com" 'http://127.0.0.1:8081'
[Response<200>]    // http response OK
```

### Continuous integration

The pipeline for this project was created with CircleCI. 
Pipeline is linked with the [github repository](https://github.com/alexmilis/avlProject) and is triggered on every push to repo.
Only the pushes on branch `main` trigger the publishing of images on Docker Hub.
Images on Docker Hub can be found in repositories:
- [service1](https://hub.docker.com/repository/docker/alexmilis/service1)
- [service2](https://hub.docker.com/repository/docker/alexmilis/service2)


### Continuous deployment

To pull images and deploy use script `deploy-docker.sh`. This script requires versions for both services. An example of valid call is below.
This script creates a custom docker compose file with the specified versions of services. 
Then it pulls those versions from Docker Hub and deploys the docker compose custom file.

```
sudo ./deploy-docker.sh --version_service1=latest --version_service2=latest
```


### Kubernetes

Each service has its own Kubernetes `deployment.yaml` file. To create the deployments use the following commands:
```
minikube start
kubectl create -f service1/deployment.yaml
kubectl create -f service2/deployment.yaml
```

To deploy both services locally use script `deploy-kubernetes.sh`.
```
./deploy-kubernetes.sh --version_service1=latest --version_service2=latest
```


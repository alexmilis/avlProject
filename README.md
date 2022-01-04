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
067d907dbce682c49ebc5589b3230cd6    // webpage hash
```
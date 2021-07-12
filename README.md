# PHP8 AWS Lambda Runtime under Alpine Linux docker image
Repo for the docker image for php8 compiled and runtime for aws lambda serverless

Or Create build container for production
```bash
docker build . -t php8-serverless
```

Create local test
```bash
docker-compose up
```

Simple local test
```
curl -XGET "http://localhost:9000/2015-03-31/functions/function/invocations"
```

To local test with query string params
```
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"queryStringParameters": {"name":"Leo"}}'
```
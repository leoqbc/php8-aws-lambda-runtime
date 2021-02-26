# PHP8 AWS Lambda Runtime docker image
Repo for the docker image for php8 compiled and runtime for aws lambda serverless

Create local build
```bash
docker build . -t php8-aws-lambda
```

Create server at port 9000
```bash
docker run --name aws-lambda -p 9000:8080 php8-aws-lambda
```

Simple local test
```
curl -XGET "http://localhost:9000/2015-03-31/functions/function/invocations"
```

To local test with query string params
```
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"queryStringParameters": {"name":"Leo"}}'
```
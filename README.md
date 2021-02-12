# PHP8 AWS Lambda Runtime docker image
Repo for the docker image for php8 compiled and runtime for aws lambda serverless

Para criar o build da imagem localmente
```bash
docker build . -t php8-aws-lambda
```

Para subir o servidor de teste na porta 9000
```bash
docker run --name aws-lambda -p 9000:8080 php8-aws-lambda
```

Para testar a execução local
```
curl -XGET "http://localhost:9000/2015-03-31/functions/function/invocations"
```

Para testar POST com execução local
```
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"queryStringParameters": {"name":"Leo"}}'
```
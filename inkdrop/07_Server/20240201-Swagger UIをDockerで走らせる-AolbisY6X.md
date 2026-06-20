# Swagger UIをDockerで走らせる


https://github.com/swagger-api/swagger-ui/blob/master/docs/usage/installation.md

これで行けた

```
docker run -p 80:8080 -e SWAGGER_JSON=/Users/yusuke.hasegawa/Downloads/api-cig-gateway-openapi-v1.0.11.yaml -v /Users/yusuke.hasegawa/Downloads:/Users/yusuke.hasegawa/Downloads  swaggerapi/swagger-ui 
```

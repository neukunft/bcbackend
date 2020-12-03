# Bootstrap

## Spring Initializr
- Kotlin
- Java 11
- Jar
- Spring Web
- Spring Actuator
- Flyway
- Prometheus
- Postgres


## Add Dependencies
### SwaggerUI
Add SwaggerUI with
```xml
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-ui</artifactId>
    <version>LATEST</version>
</dependency>
```

### Dockerbuild
If you don't intend to use a Buildpack like `./mvnw`, it is advised to use **layer** Jars, to keep Docker from re-building the whole image for every single change.

To activate Layermode, add:
```xml
<plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
    <configuration>
        <layers>
            <enabled>true</enabled>
        </layers>
    </configuration>
</plugin>
```

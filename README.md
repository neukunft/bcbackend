# backend

When spring boot runs (see maven targets), you can call
```http://localhost:8080/greeting```

## Requires
- maven
- \>= Java 11

## Docker
- Install docker based on your platform
- start container
```bash
docker run --name fusee2-db \
-p 127.0.0.1:5439:5432 \
-e POSTGRES_USER=dbuser \
-e POSTGRES_PASSWORD=fuseE3000! \
-e POSTGRES_DB=fusee \
-d postgres:13-alpine
```
- sudo docker start postgres (use run only for initial creation and start)
- sudo docker attach postgres (to get tty when using start)

## reset flyway
- mvn flyway:clean

You can use pgadmin as ui

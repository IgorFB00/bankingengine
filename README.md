# BankingEngine
To run the project you need to have a Postgres container running on port 5432.
There is a docker-compose.yml file in the project to ease setting up the environment.

# Run this to have a database on 5432
``` sh
- To have a database on 5432 run:
docker-compose up -d
```

``` sh
- To run tests, on the root folder run 
mix test
```

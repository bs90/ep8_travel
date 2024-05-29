# README
- Run

```docker-compose up --build```

- Create database (First time)

```docker-compose exec api rails db:create```

- Migrate databse

```docker-compose exec api rails db:migrate```

- Generate swagger file

```docker-compose exec api rails rswag:specs:swaggerize RAILS_ENV=test```

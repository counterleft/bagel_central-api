# Bagel Central API

[![Codeship Status for winterchord/bagel_central-api](https://codeship.com/projects/55ff50e0-0a83-0133-0d8e-269fed99bda5/status?branch=master)](https://codeship.com/projects/90699)
[![Code Climate](https://codeclimate.com/github/winterchord/bagel_central-api/badges/gpa.svg)](https://codeclimate.com/github/winterchord/bagel_central-api)
[![Test Coverage](https://codeclimate.com/github/winterchord/bagel_central-api/badges/coverage.svg)](https://codeclimate.com/github/winterchord/bagel_central-api/coverage)

A HTTP API that tracks bagels given and received in foosball games. A bagel is given to the goalie of a team that loses a game of foosball without ever scoring a point.

This project is the backend portion extracted out of [winterchord/foosball-bagels](https://github.com/winterchord/foosball-bagels), so that I can play with a 2-tier web app setup (front-/backend). The frontend will be an ember.js application. The intent of moving to a 2-tier setup is solely to experiment with frontend standalone js frameworks like ember.js, without having to conflate ember with rails in the same project.

All resources exposed through the API adhere to the [jsonapi](http://jsonapi.org/) format.

## Development

The local development workflow uses Docker and assumes that `docker` and
`docker-compose` are already installed on the developer's machine.

```sh
❯ docker --version
Docker version 1.8.1, build d12ea7

❯ docker-compose --version
docker-compose version: 1.4.0
```

The application is deployed to Heroku and uses the `heroku-docker`
toolbelt.

```sh
❯ heroku plugins:install heroku-docker
```

### Starting the app locally

```sh
❯ docker-compose up web
```

Once up, you can hit the API with:

```sh
❯ open "http://$(boot2docker ip):8080/health-statuses"
```

Note that `boot2docker` is used as a bridge to docker for non-Ubuntu
machines.

### Running rake and migrations

Use the `shell` process to get shell access to the app's container:

```sh
❯ docker-compose run shell

root@61e168fc680e:/app/user# bundle exec rake db:migrate
```

If you don't want interactive access to the container, you can run a
command directly after running `shell`:

```sh
❯ docker-compose run shell bundle exec rake
..................................

Finished in 1.044846s, 32.5407 runs/s, 164.6175 assertions/s.
34 runs, 172 assertions, no failures, no errors, no skips
```

### Rebuilding the app after making changes

```sh
❯ docker-compose stop web
❯ docker-compose build
❯ docker-compose up web
```

### References

- https://devcenter.heroku.com/articles/docker

## Deployment

Pushes to `master` will run the tests and deploy to production if
everything is successful.

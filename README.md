# WordPress Skeleton

This WordPress package uses [composer](https://getcomposer.org) and
[docker](https://www.docker.com) for development and to deploy.

## Install

```
composer create-project marcusmyers/wordpress-skeleton <your-wordpress-site>
```

## Initial Config

```
script/bootstrap
```

## Spinning up

To get the site up for development and viewing run the following
command.

```
docker-compose up -d
```

Once it's done go to `http://localhost:30000` in your browser to get
started.


## Adding Themes and Plugins

Search for themes and plugins at https://wpackagist.org.

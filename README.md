# WordPress Skeleton

This WordPress package uses [composer](https://getcomposer.org) and
[docker](https://www.docker.com) for development and to deploy.

## Install

```
echo "{}" > composer.json
composer config repositories.repo-name composer https://https://wpackagist.org
composer require marcusmyers/wordpress-skeleton
```

## Spinning up

To get the site up for development and viewing run the following
command.

```
docker-compose up -d
```

Once it's done go to `http://localhost:30000` in your browser to get
started.

server {
  listen ${APP_PORT:-80} default_server;
  server_name _;
  server_tokens off;
  root /app/web/;
  ${SSL_FLAG}
  ${SSL_CERT}
  ${SSL_CERT_KEY}

  set_real_ip_from 172.16.0.0/12;
  set_real_ip_from 10.0.0.0/8;
  real_ip_header X-Real-IP;

  index index.php;

  location / {
    try_files \$uri \$uri/ /index.php?\$args;
  }

  # Add trailing slash to */wp-admin requests.
  rewrite /wp-admin\$ \$scheme://\$host\$uri/ permanent;

  # Rewrite /status route to /status.php file.
  rewrite /status\$ /status.php last;

  location ~ \\.php\$ {
    try_files \$uri =404;

    fastcgi_split_path_info ^(.+\\.php)(/.+)\$;
    include fastcgi_params;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    fastcgi_pass unix:/run/php/php7.0-fpm.sock;
  }

  # Deny access to any files with a .php extension in the uploads directory
  # Works in sub-directory installs and also in multisite network
  location ~* /(?:uploads|files)/.*\\.php\$ {
    deny all;
  }
}

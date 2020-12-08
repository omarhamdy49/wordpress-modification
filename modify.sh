#!/usr/bin/env bash

FILE_PREFIX="wp"
NEW_PREFIX="portal"

#DataBase
DB_NAME="test"
DB_USER="root"
DB_PASSWORD="123"
DB_HOST="localhost"
TABLE_PREFIX="portal_"


printf "####### Change WP- Prefix  ####### \n"

rm readme.html license.txt
mv wp-config-sample.php wp-config.php




 for f in ${FILE_PREFIX}-*.php;
 do
   printf "${f} \t New File Name : ${NEW_NAME} \n";
   NEW_NAME=${f/#${FILE_PREFIX}-/${NEW_PREFIX}-};
   mv ${f} ${NEW_NAME};
   find . -name \*.php  -exec sed -i '' -e "s/${f}/${NEW_NAME}/g" {} \;
 done


printf "####### Change WP Directories  ####### \n"

mv ${FILE_PREFIX}-includes ${NEW_PREFIX}-includes
find . -name \*.php  -exec sed -i '' -e "s/${FILE_PREFIX}-includes/${NEW_PREFIX}-includes/g" {} \;

mv ${FILE_PREFIX}-content ${NEW_PREFIX}-content
find . -name \*.php  -exec sed -i '' -e "s/${FILE_PREFIX}-content/${NEW_PREFIX}-content/g" {} \;

mv ${FILE_PREFIX}-admin ${NEW_PREFIX}-admin
find . -name \*.php  -exec sed -i '' -e "s/${FILE_PREFIX}-admin/${NEW_PREFIX}-admin/g" {} \;
find . -name \*.php  -exec sed -i '' -e "s/class-${NEW_PREFIX}-admin/class-wp-admin/g" {} \;

printf "####### DATABASE CONFIG  ####### \n"
cat > $NEW_PREFIX-config.php << EOF
<?php
/**
 * The base configuration for Portal
 */

/** The name of the database for Portal */
define( 'DB_NAME', '$DB_NAME' );

/** MySQL database username */
define( 'DB_USER', '$DB_USER' );

/** MySQL database password */
define( 'DB_PASSWORD', '$DB_PASSWORD' );

/** MySQL hostname */
define( 'DB_HOST', '$DB_HOST' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );




\$table_prefix = '$TABLE_PREFIX';


define( 'WP_DEBUG', true );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . '$NEW_PREFIX-settings.php';

EOF

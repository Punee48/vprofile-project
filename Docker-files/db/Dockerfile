FROM mysql:8.0.33

# Add Tags
LABEL "Project"="vprofile-project"
LABEL "Author"="Puneeth"

# Add Env Variable for Password and DB Name
ENV MYSQL_ROOT_PASSWORD="vprodbpass"
ENV MYSQL_DATABASE="accounts"

# Copy the SQL File and Execute the Script to Create Tables
ADD db_backup.sql /docker-entrypoint-initdb.d/db_backup.sql
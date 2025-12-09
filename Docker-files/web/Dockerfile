FROM nginx:latest

# Remove the default nginx configuration file
RUN rm -rf /etc/nginx/conf.d/default.conf

#COPY THE NGINX CONFIG FILE 
COPY nginvproapp.conf /etc/nginx/conf.d/vproapp.conf
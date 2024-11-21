# debian easier that apache

from debian:buster

# workdir - set working directory 
# copy - from where (tools) to where ( . )
# run - cmds to run inside container
# cmd - cmds to run after container was created; 

WORKDIR /tmp/nginx/
COPY tools .
RUN chmod +x install.sh && ./install.sh && rm install.sh
CMD ["nginx", "-g", "daemon off;"]
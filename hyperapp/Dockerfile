FROM node:alpine

# install bash and nginx
RUN apk --update add bash nginx

# install sudo and set dockeruser sudoer
RUN apk add sudo \
 && echo 'node ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

# setup nginx
RUN sed -i 's/user\ \ nginx\;/user\ \ node\;/g' /etc/nginx/nginx.conf \
 && mkdir /run/nginx
ADD server.conf /etc/nginx/conf.d/default.conf

# set pre-workdir
RUN mkdir -p /var/www/happ-pre
WORKDIR /var/www/happ-pre

# create directries
RUN mkdir -p src/js \
 && mkdir src/js/components \
 && mkdir src/scss \
 && mkdir dist

# add needfiles
ADD package.json package.json
ADD .babelrc .babelrc
ADD webpack.config.js webpack.config.js
ADD index.html index.html
ADD main.jsx src/js/main.jsx
ADD style.scss src/scss/style.scss

# install nodemodules
RUN npm install --save-dev webpack babel-cli babel-preset-env babel-plugin-transform-react-jsx \
                           babel-loader node-sass jest babel-jest regenerator-runtime \
 && npm install --save hyperapp bootstrap jquery popper.js

# build js and sass
RUN npm run build

# set workdir
RUN mkdir /var/www/happ
WORKDIR /var/www/happ

# setup entrypoint
ADD happ-entrypoint.sh /bin/happ-entrypoint.sh
RUN chmod 777 /bin/happ-entrypoint.sh
USER node
ENTRYPOINT ["sh", "/bin/happ-entrypoint.sh"]
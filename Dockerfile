# build phase: install deps and build app
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN yarn
COPY . .
RUN yarn build

# RUN phase. No need for addition 'as'
FROM nginx
# AWS EBS uses this to expose/map this port. This is usually informational
EXPOSE 80
#copy from builder phase
COPY --from=builder /app/build /usr/share/nginx/html

# nginx image starts nginx automatically. No need for a CMD
#CMD ["nginx"]
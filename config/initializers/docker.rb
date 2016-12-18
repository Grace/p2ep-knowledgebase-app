# docker.rb initializer
if Rails.env.development?
  `docker-compose up -d`
end
# Imagem base do Ruby
FROM ruby:3.1.2-alpine

# Instale as dependências do sistema
RUN apk add --no-cache build-base postgresql-dev tzdata nodejs yarn

# Define o diretório de trabalho como /app
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock para o diretório de trabalho
COPY Gemfile Gemfile.lock ./

# Instale as dependências do projeto
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copie o código do aplicativo para o diretório de trabalho
COPY . .

# Precompile assets
# NOTE: The command may require adding some environment variables (e.g., SECRET_KEY_BASE) if you're not using
# credentials.
RUN bundle exec rails assets:precompile

# Finally, our production image definition
# NOTE: It's not extending the base image, it's a new one
FROM ruby:3.1.2-alpine$DISTRO_NAME AS production

# Exponha a porta 3000
EXPOSE 3000

# Inicie o servidor web
CMD ["rails", "server", "-b", "0.0.0.0"]

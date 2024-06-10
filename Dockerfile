FROM ruby:3.2.2

# Instala dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client cron

# Configura o diretório de trabalho na imagem Docker
WORKDIR /myapp

# Instala as gems necessárias
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Copia o restante do código da aplicação
COPY . /myapp

# Expõe a porta que o Rails usa
EXPOSE 3000

CMD bash -c "bundle exec whenever --update-crontab && cron -f"

# Comando padrão para inicializar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
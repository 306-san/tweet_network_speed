FROM rubylang/ruby:2.7-bionic
WORKDIR /tweet_network_speed
RUN apt update && apt upgrade -y && apt install -y curl
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN curl -Lo /tmp/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
# hotfix for run speed-cli see https://github.com/sivel/speedtest-cli/pull/769
# RUN sed -i "1174c\            map(int, (server_config['ignoreids'].split(',') if len(server_config['ignoreids']) else []) )" /tmp/speedtest-cli
RUN chmod +x /tmp/speedtest-cli && mv  /tmp/speedtest-cli /usr/local/bin
RUN apt auto-remove
# ENV INSTALL_KEY 379CE192D401AB61
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
# RUN echo "deb https://ookla.bintray.com/debian generic main" | tee  /etc/apt/sources.list.d/speedtest.list
# RUN apt update && apt install -y speedtest
COPY ./Gemfile .
COPY ./Gemfile.lock .
RUN bundle install

COPY . .
CMD ["bundle", "exec", "ruby", "main.rb"]


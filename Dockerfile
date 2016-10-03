FROM java:8-jre
MAINTAINER Matt Strenz <matt.strenz@readytalk.com>
 
ENV DISPLAY=:1.0
RUN apt-get update && apt-get install -y vim xvfb python3 default-jre-headless python3-tk python3-pip python3-dev libxml2-dev libxslt-dev zlib1g-dev

RUN pip3 install bzt
RUN pip3 install --upgrade bzt
RUN rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/*

ENV url https://qa-www.readytalk.com/
ENV users 5
ENV length 60s

RUN mkdir /tmp/load
WORKDIR /tmp/load
ENV HOME /tmp/load

COPY quick_test.yml /root/
COPY site_test.yml /root/

RUN bzt quick_test.yml
RUN rm -r /tmp/load/*-*-*_*-*-*.*
RUN chmod a+x .bzt/jmeter-taurus/bin/jmeter .bzt/jmeter-taurus/bin/jmeter-server .bzt/jmeter-taurus/bin/*.sh
RUN ln -s .bzt/jmeter-taurus/bin/jmeter
RUN ln -s .bzt/jmeter-taurus/bin/jmeter-server

VOLUME /results
RUN chmod a+w /results

CMD bzt \
    -o scenarios.load.requests="['${url}']" \
    -o modules.console.disable=true \
    -o execution.0.concurrency=${users} \
    -o execution.0.hold-for=${length} site_test.yml 
 

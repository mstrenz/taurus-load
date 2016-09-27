FROM java:8-jre
MAINTAINER Matt Strenz <matt.strenz@readytalk.com>
 
ENV DISPLAY=:1.0
RUN apt-get update && apt-get install -y vim xvfb python3 default-jre-headless python3-tk python3-pip python3-dev libxml2-dev libxslt-dev zlib1g-dev
RUN pip3 install bzt
RUN pip3 install --upgrade bzt
RUN rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/*
ENV test https://qa-www.readytalk.com/


COPY quick_test.yml /root/
COPY site_test.yml /root/
WORKDIR /root
RUN bzt quick_test.yml
RUN rm -r /root/*-*-*_*-*-*.*
RUN chmod a+x .bzt/jmeter-taurus/bin/jmeter .bzt/jmeter-taurus/bin/jmeter-server .bzt/jmeter-taurus/bin/*.sh
RUN ln -s .bzt/jmeter-taurus/bin/jmeter
RUN ln -s .bzt/jmeter-taurus/bin/jmeter-server

VOLUME /results

CMD bzt \
    -o scenarios.low.requests="['${test}']" \
    -o scenarios.med.requests="['${test}']" \
    -o scenarios.high.requests="['${test}']" site_test.yml
 

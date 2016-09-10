FROM debian:jessie

WORKDIR /root/

ADD scripts/ scripts/
RUN scripts/bootstrap.sh

ADD vendor vendor/
ADD manifests manifests/
ADD modules modules/
ADD hiera hiera/
ADD Makefile hiera.yaml ./

ENV facter_env docker
RUN scripts/apply.sh

RUN cp /sbin/init /sbin/init.real

CMD /usr/sbin/nginx -g 'daemon off;'
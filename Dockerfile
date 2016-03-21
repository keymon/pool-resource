FROM alpine:3.3

ENV AWSCLI_VERSION "1.9.21"
ENV PACKAGES "git openssh-client groff less python py-pip curl openssl ca-certificates jq"

RUN apk add --update $PACKAGES \
    && pip install awscli==$AWSCLI_VERSION \
    && apk --purge -v del py-pip \
    && rm -rf /var/cache/apk/*

ENV LANG C

ADD assets/ /opt/resource/
RUN chmod +x /opt/resource/*

ADD built-out /opt/go/out
RUN chmod +x /opt/go/out

ADD test/ /opt/resource-tests/
RUN /opt/resource-tests/all.sh

ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as base


RUN touch /.dummy

#--------------------------------------
# test: php 7.4
#--------------------------------------
FROM base as testa

# renovate: datasource=docker versioning=docker
RUN install-tool php 7.4.6

# renovate: datasource=github-releases depName=composer/composer
RUN install-tool composer 1.10.5

USER ubuntu

RUN set -ex; \
  [ ! -z "$(command -v php)" ] && echo "php installed" || exit 1;

RUN set -ex; \
  $(php -r 'exit(extension_loaded("mbstring") ? 0 : 1);') && echo "php-mbstring installed" || exit 1;

RUN set -ex; \
  $(php -r 'exit(extension_loaded("curl") ? 0 : 1);') && echo "php-curl installed" || exit 1;

RUN set -ex; \
  $(php -r 'exit(extension_loaded("xml") ? 0 : 1);') && echo "php-xml installed" || exit 1;

RUN set -ex; \
  $(php -r 'exit(extension_loaded("json") ? 0 : 1);') && echo "php-json installed" || exit 1;

RUN php --version
RUN composer --version


RUN set -ex; \
  git clone https://github.com/renovate-tests/composerlock3.git; \
  cd composerlock3/backend; \
  composer install --no-ansi --no-interaction; \
  cd ..; \
  git status -s;

#--------------------------------------
# test: php 5.6
#--------------------------------------
FROM base as testb

# renovate: datasource=docker versioning=docker
RUN install-tool php 5.6.40

# renovate: datasource=github-releases depName=composer/composer
RUN install-tool composer 1.10.5

USER ubuntu

RUN set -ex; \
  [ ! -z "$(command -v php)" ] && echo "php installed" || exit 1;

RUN set -ex; \
  $(php -r 'exit(extension_loaded("mbstring") ? 0 : 1);') && echo "php-mbstring installed" || exit 1;

RUN set -ex; \
  $(php -r 'exit(extension_loaded("curl") ? 0 : 1);') && echo "php-curl installed" || exit 1;

RUN set -ex; \
  $(php -r 'exit(extension_loaded("xml") ? 0 : 1);') && echo "php-xml installed" || exit 1;

RUN set -ex; \
  $(php -r 'exit(extension_loaded("json") ? 0 : 1);') && echo "php-json installed" || exit 1;

RUN php --version
RUN composer --version


#--------------------------------------
# final
#--------------------------------------
FROM base

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy

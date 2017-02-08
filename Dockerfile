from alpine:3.5

env MODD=https://github.com/cortesi/modd/releases/download/v0.4/modd-0.4-linux64.tgz \
  MODD_PATH=/modd-0.4-linux64/modd \
  GIT_NAME="git-sync" \
  GIT_EMAIL="git-sync@git-sync"

run apk add --no-cache \
    git git-gitweb git-daemon \
    rsync nginx fcgiwrap spawn-fcgi perl-cgi \
    wget python py2-jinja2 && \
  wget "$MODD" -O /modd.tar.gz && \
  tar xf /modd.tar.gz && \
  rm /modd.tar.gz && \
  mkdir /src /git

copy modd.conf /modd.conf
copy gitweb.conf.j2 /etc/gitweb.conf.j2
copy nginx.conf /etc/nginx/nginx.conf
copy init.sh sync.sh nginx.sh template.py /

expose 80 9418

cmd "$MODD_PATH"

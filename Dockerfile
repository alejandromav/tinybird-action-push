FROM python:3.10-slim

LABEL "maintainer"="Alejandro Martin <hi@alejandromav.com>"
LABEL "repository"="https://github.com/alejandromav/tinybird-action-push"
LABEL "homepage"="https://github.com/alejandromav/tinybird-action-push"

LABEL "com.github.actions.name"="tinybird-push"
LABEL "com.github.actions.description"="Push changes to Tinybird data project"
LABEL "com.github.actions.icon"="upload"
LABEL "com.github.actions.color"="white"

RUN apt-get update && apt-get install -y git
RUN pip install tinybird-cli

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]

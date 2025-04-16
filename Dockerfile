# Jupyter Lab: https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html
# Open browser tab: http://localhost:8888/lab

FROM quay.io/jupyter/minimal-notebook:python-3.12

# Install system dependencies
ARG NB_USER
ARG NB_UID
ENV USER=${NB_USER}
ENV NB_UID=${NB_UID}
ENV HOME=/home/${NB_USER}

## Copies all repo files into the Docker Container
USER root
COPY . ${HOME}
RUN chown -R ${NB_UID} ${HOME}

# Install system dependencies
RUN apt-get update && apt-get install -y build-essential pkg-config

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r ${HOME}/requirements.txt

RUN rmdir work

USER ${NB_USER}

# --- Metadata ---
LABEL maintainer="carlos.granell@uji.es" \
Name="jupyter/minimal-notebook with installed packages" \
  org.opencontainers.image.created="2025-04" \
  org.opencontainers.image.authors="Carlos Granell"
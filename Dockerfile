FROM pytorch/pytorch:2.7.1-cuda12.8-cudnn9-devel
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3.10-venv \
    python3-dev \
    ffmpeg \
    rdma-core \
    libibverbs-dev \
    ibverbs-providers \
    ibverbs-utils \
    rdmacm-utils \
    libibverbs1 \
    librdmacm1 \
    libibumad3 \
    libmlx5-1 \
    infiniband-diags

# gcloud needed to authenticate with GCP for gsutil etc
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin

RUN mkdir src 
RUN pip install --upgrade torch

RUN git clone https://github.com/Dao-AILab/flash-attention.git --depth 1 --branch v2.8.1 /src/flash-attention
RUN cd /src/flash-attention/hopper && MAX_JOBS=12 python setup.py install

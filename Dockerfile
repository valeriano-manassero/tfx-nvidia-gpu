FROM tensorflow/tfx:0.27.0

ENV CUDA_VERSION 11.2.1
ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.2 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 driver>=450,driver<451"
ENV CUDNN_VERSION 8.1.0.77
ENV TF_FORCE_GPU_ALLOW_GROWTH true

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates apt-transport-https gnupg-curl && \
    NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    NVIDIA_GPGKEY_FPR=ae09fe4bbd223a84b2ccfce3f60f4b3d7fa2af80 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
    apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +5 > cudasign.pub && \
    echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && apt-get install -y --no-install-recommends \
    cuda-cudart-11-2=11.2.146-1 \
    cuda-compat-11-2 \
    cuda-libraries-11-2=11.2.1-1 \
    libnpp-11-2=11.3.2.139-1 \
    cuda-nvtx-11-2=11.2.67-1 \
    libcublas-11-2=11.4.1.1026-1 \
    libcusparse-11-2=11.4.0.135-1 \
    libcudnn8=$CUDNN_VERSION-1+cuda11.2 \
    && ln -s cuda-11.2 /usr/local/cuda && \
    echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf \
    && echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf && \
    apt-get purge --auto-remove -y gnupg-curl && \
    apt-mark hold libcublas-11-2 && \
    apt-mark hold libcudnn8 && \
    rm -rf /var/lib/apt/lists/*

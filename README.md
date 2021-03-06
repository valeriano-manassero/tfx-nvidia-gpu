# Tensorflow TFX with NVIDIA drivers

Tensorflow TFX with NVIDIA drivers included for easy usage; it can be used on TFX pipelines on Kubeflow where the underlying Kubernetes have supported GPU nodes.

## Getting Started

Refer this image into TFX pipeline.

### Requirements

In order to run this container you need a Kubeflow installation with NVIDIA GPU enabled nodes.

### Usage

In TFX Kubeflow pipeline image must be set to customa value: `valerianomanassero/tfx-nvidia-gpu:<version>`
Images available tags are on https://hub.docker.com/r/valerianomanassero/tfx-nvidia-gpu/tags

## Contributing

Please read [CONTRIBUTING](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## License

This project is licensed under the Apache License License - see the [LICENSE](LICENSE) file for details.

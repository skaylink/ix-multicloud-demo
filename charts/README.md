# Helm Charts

In this folder you find the helm charts of our example apps. Each contains some basic k8s resources as YAML definitions, which sets up the application in place.

## Development

The helm charts are created by the command `helm create klaus` and have only small modifications.

They now can be modified heavily to fit your application, so feel free to copy and modify. :)

## Installation

In our example repository setup, we do install these helm charts through terraform modules, you can find them in the `/terraform` folder.

But you can also directly install the helm charts by going into the current `/charts` folder in your CLI terminal and run the following command:

```sh
# Installation of the klaus example application
$ helm install klaus ./petra

# Installation of the petra example application
$ helm install petra ./petra
```

The default configuration will miss the ingress configuration of the klaus application, but you can fix this by modifing the values file or using `--set` arguments.

More in the [official helm documentation](https://helm.sh/docs/) about configure, upgrade and modifying helm releases.

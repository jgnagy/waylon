# Deploying Waylon to Kubernetes

This is an example of deploying a Waylon image to Kubernetes. To use it, you must identify a hostname for Waylon to be externally accessible (for plugins that require that) in `web-ingress.yaml`. You must also set the image used for the containers in `web-deployment.yaml` and `worker-deployment.yaml` to your pre-built Waylon docker image.

Once these modifications are made, you can launch Waylon on your Kubernetes cluster using something like:

```sh
$ kubectl -n some-namespace apply -f *.yaml
```

The files in this example make some hefty assumptions, such as that your cluster has a `StorageClass` called `longhorn` and that you won't need credentials to pull images from your registry. Please be sure to review the files fully and make any necessary changes before using them.

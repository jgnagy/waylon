# Waylon Helm Chart

This is an example (though fairly complete) Helm chart for running a [Waylon](https://github.com/jgnagy/waylon) chat bot.

## Usage

* Review the list of parameters and decide what needs to be changed. You'll need _at least_ to have previously built and published a Waylon Docker image and you'll need to decide on a domain name. You'll provide these values when you render the template.

* Render the template to a file:

```sh
$ helm template ./waylon --set common.waylonImage="some.docker.registry/project/mywaylon:1.2.3" --set web.ingress.hostname="foo.bar.com" > /tmp/waylon.yaml
```

* Deploy your rendered template:

```sh
$ kubectl -n some-namespace apply -f /tmp/waylon.yaml
```

## Parameters

| Setting | Default Value |  Description |
| --- | --- | --- |
| `common.strictSecrurity` | `true` | Should stricter security controls be enabled? |
| `common.waylonImage` | _none_ | The full docker image to pull for your Waylon deployment |
| `common.imagePullSecret` | _none_ | Completely optional secret to use when pulling images from private repos |
| `redis.enabled` | `true` | Should a dedicated Redis be deployed for alongside Waylon? |
| `redis.annotations` | `{}` | Optionally list any additional annotations for the Redis StatefulSet. **Note:** these are not passed-through to the Pods. |
| `redis.labels` | `{}` | Optionally list any additional labels for the Redis StatefulSet. **Note:** these are not passed-through to the Pods. |
| `redis.hostAndPort` | `redis:6379` | Tells Waylon how to find Redis. If `redis.enabled` is `false`, be sure to update this, otherwise it can be left alone. |
| `redis.image` | `redis:6-alpine` | The full docker image to use for Redis |
| `redis.imagePullPolicy` | `Always` | How often to try pulling the Redis docker image |
| `redis.command` | `["redis-server", "--appendonly yes"]` | Usually best to leave this alone, but it allows setting more advanced Redis settings |
| `redis.cpuLimit` | `200m` | How much CPU can Redis use? |
| `redis.memoryLimit` | `512Mi` | How much memory can Redis use? |
| `redis.storage.capacity` | `5Gi` | How much disk space can Redis use? It shouldn't need much given how it is used but adjust based on your plugins and expected load. |
| `redis.storage.class` | `longhorn` | What [Kubernetes StorageClass](https://kubernetes.io/docs/concepts/storage/storage-classes/) should Redis use? |
| `web.deployment.annotations` | `{}` | Optionally list any additional annotations for the Waylon web Deployment. **Note:** these are not passed-through to the Pods. |
| `web.deployment.imagePullPolicy` | `IfNotPresent` | How often to try pulling the Waylon image for the Web deployment |
| `web.deployment.labels` | `{}` | Optionally list any additional labels for the Waylon web Deployment. **Note:** these are not passed-through to the Pods. |
| `web.deployment.logLevel` | `DEBUG` | What log level should the Waylon web component use? |
| `web.deployment.maxSurge` | `2` | How many _additional_ Pods can the deployment create to handle a rollout/update? |
| `web.deployment.maxUnavailable` | `0` | How many Pods can be unavailble during a deployment rollout? |
| `web.deployment.replicas` | `1` | How many Pods do want to run for Waylon's web component? |
| `web.deployment.cpuLimit` | `250m` | How much CPU can Redis use? |
| `web.deployment.memoryLimit` | `256Mi` | How much memory can Redis use? |
| `web.ingress.enabled` | `true` | Should Waylon have an Ingress for its web component? |
| `web.ingress.class` | `nginx` | What Ingress class will be use for `kubernetes.io/ingress.class`? |
| `web.ingress.hostname` | _none_ | What hostname will the Web component use (also used for TLS) |
| `web.ingress.tls.enabled` | `true` | Should the Ingress use TLS (HTTPS)? |
| `web.ingress.tls.issuer` | `letsencrypt` | What is the name of the Issuer/ClusterIssuer that will be used for provisioning TLS secrets? |
| `web.ingress.tls.issuerClass` | `ClusterIssuer` | Is the TLS issuer a `ClusterIssuer` or an `Issuer`? You can usually ignore this setting. |
| `web.service.port` | `80` | The port that the Service listens on |
| `web.service.type` | `ClusterIP` | The Service type |
| `worker.deployment.annotations` | `{}` | Optionally list any additional annotations for the Waylon worker Deployment. **Note:** these are not passed-through to the Pods. |
| `worker.deployment.imagePullPolicy` | `IfNotPresent` | How often to try pulling the Waylon image for the worker Deployment |
| `worker.deployment.labels` | `{}` | Optionally list any additional labels for the Waylon worker Deployment. **Note:** these are not passed-through to the Pods. |
| `worker.deployment.logLevel` | `DEBUG` | What log level should the Waylon worker component use? |
| `worker.deployment.maxSurge` | `2` | How many _additional_ Pods can the deployment create to handle a rollout/update? |
| `worker.deployment.maxUnavailable` | `0` | How many Pods can be unavailble during a deployment rollout? |
| `worker.deployment.replicas` | `1` | How many Pods do want to run for Waylon's web component? |
| `worker.deployment.cpuLimit` | `250m` | How much CPU can Redis use? |
| `worker.deployment.memoryLimit` | `256Mi` | How much memory can Redis use? |

See the [default `values.yaml`](values.yaml) for a full view of the default settings.

### Some Gotchas

* You **MUST** set `common.waylonImage` and, if you plan on using an Ingress for Waylon, `web.ingress.hostname`.
* If your TLS issuer is not named `letsencrypt` but uses the ACMEv2 protocol via cert-manager, you might need to add to `web.ingress.annotations` so it contains an entry like `cert-manager.io/acme-challenge-type: http01`. This is only _automatically_ added if your issuer is called `letsencrypt`.

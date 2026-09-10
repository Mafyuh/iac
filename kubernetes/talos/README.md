```
talhelper genconfig
```

```
talosctl apply-config --nodes 10.0.0.201 --file clusterconfig/optiplex-k8s-talos-4.yaml
talosctl apply-config --nodes 10.0.0.202 --file clusterconfig/optiplex-k8s-talos-5.yaml
talosctl apply-config --nodes 10.0.0.203 --file clusterconfig/optiplex-k8s-talos-6.yaml
```

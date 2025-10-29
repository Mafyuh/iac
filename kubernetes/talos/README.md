```
talhelper genconfig
```

```
talosctl apply-config --nodes 10.0.0.9 --file clusterconfig/optiplex-k8s-talos-1.mafyuh.com.yaml
talosctl apply-config --nodes 10.0.0.84 --file clusterconfig/optiplex-k8s-talos-2.mafyuh.com.yaml
talosctl apply-config --nodes 10.0.0.177 --file clusterconfig/optiplex-k8s-talos-3.mafyuh.com.yaml
```

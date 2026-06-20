# GAE instance classの変更


https://cloud.google.com/appengine/docs/standard?hl=ja
https://cloud.google.com/appengine/docs/standard/python3/config/appref?hl=ja#instance_class
https://cloud.google.com/appengine/docs/standard/python3/config/appref?hl=ja#automatic_scaling

[GAEを使うときはmax_idle_instancesを指定した方がいい](https://zenn.dev/catnose99/scraps/64f945d242a8376d942a)


```
instance_class: F2
automatic_scaling:
  max_instances: 1
  max_idle_instances: 1
```
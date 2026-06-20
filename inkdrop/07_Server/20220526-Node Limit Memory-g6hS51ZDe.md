# Node Limit Memory


[Node.js Memory Limits - What You Should Know | AppSignal Blog](https://blog.appsignal.com/2021/12/08/nodejs-memory-limits-what-you-should-know.html)

[node.js の --max-old-space-size のデフォルト値は 1400MB - Qiita](https://qiita.com/kawanet/items/cfedd535990b32710c50)

```
Exceeded soft memory limit of 256 MB with 259 MB after servicing 57 requests total. Consider setting a larger instance class in app.yaml.

While handling this request, the process that handled this request was found to be using too much memory and was terminated. This is likely to cause a new process to be used for the next request to your application. If you see this message frequently, you may have a memory leak in your application or may be using an instance with insufficient memory. Consider setting a larger instance class in app.yaml.

```


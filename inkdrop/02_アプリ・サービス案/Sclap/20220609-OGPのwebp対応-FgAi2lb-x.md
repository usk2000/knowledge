# OGPのwebp対応


- 通常の画像：WebPにする
- OGP画像：WebPにしたいが、ちょっと時間がかかりそう

[Node.jsのライブラリsharpの出力形式について | Simple is Beautiful.](https://blog.kozakana.net/2019/04/sharp-output-format/)
[Output options - sharp - High performance Node.js image processing](https://sharp.pixelplumbing.com/api-output)

→OGP画像が、これに対応できない?
[node.js - How to convert a remote webp image to a png image to load it into node-canvas - Stack Overflow](https://stackoverflow.com/questions/65076410/how-to-convert-a-remote-webp-image-to-a-png-image-to-load-it-into-node-canvas)

node-canvas
[mjgerace/node-canvas-webp: Experimental webp encoding extension for node-canvas](https://github.com/mjgerace/node-canvas-webp)
[Webp · Issue #562 · Automattic/node-canvas](https://github.com/Automattic/node-canvas/issues/562)

直接はできないかも。
canvas -> sharp -> webp



# Streaming protocol

Mobileから考えると
- http live streaming
  - high-latency
  - low latency
- WebRTC
が有力。

[Everything You Need to Know About Video Streaming Protocols](https://blog.vidizmo.com/everything-you-need-to-know-about-video-streaming-protocols#HLS)

[低遅延動画配信 Apple Low Latency HLS を試す - Qiita](https://qiita.com/tomopyonsama/items/a113a0cb1bd4dfdbb2a2)

[Enabling Low-Latency HTTP Live Streaming (HLS) | Apple Developer Documentation](https://developer.apple.com/documentation/http_live_streaming/enabling_low-latency_http_live_streaming_hls)

スケーラブルが必要なわけ
[ビデオストリーミング](http://umdb.um.u-tokyo.ac.jp/DPastExh/Publish_db/2000dm2k/japanese/01/01-13.html)
一定のクオリティが必要な場合にスケーラブルが必要

レイテンシーについて
- 数秒以内の遅延の即時確認が必要な場合：低レイテンシーが必要
- 即時確認が必要でない、高画質でも良い：高レイテンシーで



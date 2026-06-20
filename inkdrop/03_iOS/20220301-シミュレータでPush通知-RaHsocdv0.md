# シミュレータでPush通知


https://qiita.com/koogawa/items/85c0dd0abd2f1970c5fc

https://developer.apple.com/documentation/xcode-release-notes/xcode-11_4-release-notes

> Simulator supports simulating remote push notifications, including background content fetch notifications. In Simulator, drag and drop an APNs file onto the target simulator. The file must be a JSON file with a valid Apple Push Notification Service payload, including the “aps” key. It must also contain a top-level “Simulator Target Bundle” with a string value that matches the target application’s bundle identifier.simctl also supports sending simulated push notifications. If the file contains “Simulator Target Bundle” the bundle identifier is not required, otherwise you must provide it as an argument (8164566):
> 
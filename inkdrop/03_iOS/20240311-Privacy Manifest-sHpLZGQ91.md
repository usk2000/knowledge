# Privacy Manifest


[Privacy manifest files | Apple Developer Documentation](https://developer.apple.com/documentation/bundleresources/privacy_manifest_files)

[Describing use of required reason API | Apple Developer Documentation](https://developer.apple.com/documentation/bundleresources/privacy_manifest_files/describing_use_of_required_reason_api)
→UserDefaultsは結構当てはまっていそう

`NSPrivacyAccessedAPITypeReasons`で記載する

`CA92.1`
> Declare this reason to access user defaults to read and write information that is only accessible to the app itself.
  This reason does not permit reading information that was written by other apps or the system, or writing information that can be accessed by other apps.

→このアプリだけアクセスする時

`1C8F.1`
> Declare this reason to access user defaults to read and write information that is only accessible to the apps, app extensions, and App Clips that are members of the same App Group as the app itself.
  This reason does not permit reading information that was written by apps, app extensions, or App Clips outside the same App Group or by the system. This reason also does not permit writing information that can be accessed by apps, app extensions, or App Clips outside the same App Group.

→このアプリとApp Extensions, App Clipsなど同じApp Groupだけでアクセスする時

`C56D.1`
> Declare this reason if your third-party SDK is providing a wrapper function around user defaults API(s) for the app to use, and you only access the user defaults APIs when the app calls your wrapper function. This reason may only be declared by third-party SDKs. This reason may not be declared if your third-party SDK was created primarily to wrap required reason API(s). 
  Information accessed for this reason, or any derived information, may not be used for your third-party SDK’s own purposes or sent off-device by your third-party SDK.

→SDKでWrapperとしてアクセスする場合。SDK側で対応する

`AC6B.1`
> Declare this reason to access user defaults to read the `com.apple.configuration.managed` key to retrieve the managed app configuration set by MDM, or to set the `com.apple.feedback.managed` key to store feedback information to be queried over MDM, as described in the Apple Mobile Device Management Protocol Reference documentation.

→特定のキーを参照するとき



[2024年春以降、Privacy Manifests未対応のiOSアプリはリジェクトされてしまう | DevelopersIO](https://dev.classmethod.jp/articles/support-privacy-manifests-for-ios-app/)



### 対応SDKチェック
[サードパーティSDKのPrivacy Manifests対応状況を調査した | DevelopersIO](https://dev.classmethod.jp/articles/surveyed-the-status-of-privacy-manifests-support-for-third-party-sdks/)
[サードパーティSDKのPrivacy Manifests対応状況確認スクリプト](https://zenn.dev/spacemarket/articles/privacy-manifest)

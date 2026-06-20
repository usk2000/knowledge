# SPMとSSH


[Authenticating with private GitHub repositories in Swift Package Manager using SSH keys | by Ian Partridge | Medium](https://medium.com/@ianpartridge/swift-package-manager-github-ssh-e8256c374e16)


SSHキーを使う。

```swift
dependencies: [
  .package(url: "git@github.com:user/private-repo.git",
           from: "1.0.0")
]
```
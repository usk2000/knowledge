# Wallet Appを起動する方法


https://stackoverflow.com/questions/40397515/ios-how-to-take-user-directly-to-the-wallet-app

```swift
let setupButton = PKPaymentButton(type: .setUp, style: .black)

or

let library = PKPassLibrary()
library.openPaymentSetup()
```
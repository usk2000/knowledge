# List, Sectionの中に複数のButton


複数のButtonのタップが誤認される
https://chatgpt.com/g/g-p-6764fd42c430819184395898622948c8-sohutouea/c/6819e1fd-8c54-800a-87f2-6ff4971da9e7https://chatgpt.com/g/g-p-6764fd42c430819184395898622948c8-sohutouea/c/6819e1fd-8c54-800a-87f2-6ff4971da9e7

```swift
List {
    Section {
        Button("A") { print("A tapped") }
        Button("B") { print("B tapped") }
    }
}
```
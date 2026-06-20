# NavigationStack


https://chatgpt.com/g/g-p-6764fd42c430819184395898622948c8-sohutouea/c/676b9404-119c-800a-8c61-60fc0c7aecac


[NavigationStack](https://developer.apple.com/documentation/swiftui/navigationstack)

```swift
NavigationStack {
    List(parks) { park in
        NavigationLink(park.name, value: park)
    }
    .navigationDestination(for: Park.self) { park in
        ParkDetails(park: park)
    }
}
```
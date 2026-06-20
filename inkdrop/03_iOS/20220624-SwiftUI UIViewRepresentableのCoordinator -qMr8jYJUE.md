# SwiftUI UIViewRepresentableのCoordinator 


[UIViewRepresentableのCoordinatorはなぜ必要か - The Pragmatic Ball boy](https://yanamura.hatenablog.com/entry/2022/03/02/101925)

UIViewRepresentableの中で、これが必要
```
    public class Coordinator: NSObject {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

```

UIViewはclassベースなので、structにdelegateを適用できない。

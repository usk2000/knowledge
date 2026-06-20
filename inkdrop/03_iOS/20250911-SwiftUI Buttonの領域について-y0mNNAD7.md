# SwiftUI Buttonの領域について


https://chatgpt.com/g/g-p-687dbb9fc36881919167481fc60bd71c-ios/c/68c26e96-784c-8328-a074-8343de0132e0

Buttonだけでなく、onTapもかな？
→調べてアウトプットする

```swift
    public var body: some View {
        Button(action: onClick) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                }
                Text(title)
                    .font(.headline).fontWeight(.bold)
                    .foregroundColor(textColor)
            }
            // ← ラベルの根本で領域を定義
            .frame(maxWidth: .infinity, minHeight: height)
            .padding(.horizontal, 16)
            .background(backgroundColor)
            .contentShape(Rectangle()) // 透明部もタップ対象（任意）
            .cornerRadius(8)
        }
        .disabled(isLoading)
    }
```
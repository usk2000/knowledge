# SwiftUI Markdown Text View


https://stackoverflow.com/questions/73817340/multiline-text-formating

```swift
struct MultilineTextView: View {
    
    let text: String
    
    var body: some View {
        HStack {
            if let attributedString = try? AttributedString(markdown: text, options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)) {
                Text(attributedString)
                    .padding(16)
            } else {
                Text(text)
                    .padding(16)
                    .foregroundStyle(Color.gray)
            }
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 4)
            .fill(Color(white: 0.95)))
    }
}

#Preview {
    MultilineTextView(text: """
お知らせお知らせ
お知らせ
[リンクはこちら](https://www.apple.com)
"""
    )
}
```

これで行ける
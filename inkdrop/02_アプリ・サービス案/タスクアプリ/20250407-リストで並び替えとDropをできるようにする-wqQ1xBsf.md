# リストで並び替えとDropをできるようにする


https://chatgpt.com/g/g-p-6764fd42c430819184395898622948c8-sohutouea/c/67f33792-f76c-800a-9117-3a77aa2fb965

struct ReorderableListView: View {
    @State private var items = Array(0..<10).map { "Item \($0)" }
    @State private var draggingItem: String? = nil
    @State private var dragLocation: CGPoint = .zero
    @State private var footerFrame: CGRect = .zero
    @State private var itemFrames: [String: CGRect] = [:]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                            .padding()
                            .background(draggingItem == item ? Color.blue.opacity(0.3) : Color.white)
                            .overlay(
                                GeometryReader { geo in
                                    Color.clear.onAppear {
                                        itemFrames[item] = geo.frame(in: .global)
                                    }
                                    .onChange(of: dragLocation) { _ in
                                        itemFrames[item] = geo.frame(in: .global)
                                    }
                                }
                            )
                            .onLongPressGesture(minimumDuration: 0.2) {
                                draggingItem = item
                            }
                    }
                }
            }
            .background(
                DragGesture()
                    .onChanged { value in
                        dragLocation = value.location
                        if let dragging = draggingItem {
                            if let targetItem = itemFrames.first(where: { $0.value.contains(value.location) })?.key,
                               let from = items.firstIndex(of: dragging),
                               let to = items.firstIndex(of: targetItem),
                               from != to {
                                withAnimation {
                                    items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
                                }
                            }
                        }
                    }
                    .onEnded { value in
                        if footerFrame.contains(value.location) {
                            print("Dropped on footer!")
                            // Footerでの処理
                        }
                        draggingItem = nil
                    }
            )

            Text("Footer")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(
                    GeometryReader { geo in
                        Color.gray.opacity(0.3)
                            .onAppear {
                                footerFrame = geo.frame(in: .global)
                            }
                            .onChange(of: dragLocation) { _ in
                                footerFrame = geo.frame(in: .global)
                            }
                    }
                )
        }
    }
}

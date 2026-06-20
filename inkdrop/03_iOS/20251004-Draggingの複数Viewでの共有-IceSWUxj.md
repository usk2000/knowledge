# Draggingの複数Viewでの共有


ステートを共有する。deleteが実装できているから、応用する。
必要であればAsuncStream


- タブとリストの２種類のDragDelegateがある
  - 加えて、終端検知用のDelegateと削除用のDelegate
- `ContentView>TabView`と`ContentView>ListView`がある
- Dragging中のアイテムを保持するためのstructが必要
- さらに、debounce中かどうかの判定も必要そう。
- 
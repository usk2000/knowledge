# BaseViewModel


```swift
import Foundation

protocol BaseViewModelContract {
    associatedtype State: Sendable
    associatedtype Action: Sendable
    associatedtype Effect: Sendable
}

@MainActor
class BaseViewModel<C: BaseViewModelContract>: @unchecked Sendable {
    typealias Contract = C
    typealias State   = C.State
    typealias Action  = C.Action
    typealias Effect  = C.Effect

    // Effect 用ストリーム（内部で生成して自分で監視する）
    private let effectsStream: AsyncStream<Effect>
    private let effectsContinuation: AsyncStream<Effect>.Continuation

    init() {
        (effectsStream, effectsContinuation) = AsyncStream.makeStream()
    }

    // Action はサブクラスで実装
    func send(_ action: Action) {
        // override で実装
    }

    // ---- Effect まわり ----

    /// サブクラス・UseCase などから Effect を流す
    func emit(_ effect: Effect) {
        effectsContinuation.yield(effect)
    }

    /// View 側から `.task { await viewModel.startObservation() }` で呼んでもらう前提
    /// 自身の effectsStream を監視して、onEmit に流す
    func startObservation() async {
        for await effect in effectsStream {
            await onEmit(effect)
        }
    }

    /// 受け取った effect をどう扱うか（サブクラスで override）
    /// ここで state 更新や「一度きりイベント用のState更新」などを行う
    func onEmit(_ effect: Effect) async {
        // デフォルトは何もしない
    }

    deinit {
        effectsContinuation.finish()
    }
}
```
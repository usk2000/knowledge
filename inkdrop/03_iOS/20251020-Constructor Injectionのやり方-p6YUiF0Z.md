# Constructor Injectionのやり方


swift-dependenciesでのConstruct Injectionのやり方をまとめる

`struct Deps`でまとめると良さそう

```swift
struct ResourcesModules {
  struct Deps {
    let classroomResources: ClassroomResources
    let courseResources: CourseResources
    let contentResources: ContentResources
    let laboratoryResources: LaboratoryResources
    let memberResources: MemberResources
    let topResources: TopResources
  }

  static let live: Deps = .init(
    classroomResources: .init(),
    courseResources: .init(),
    contentResources: .init(),
    laboratoryResources: .init(),
    memberResources: .init(),
    topResources: .init()
  )

  static let mock: Deps = .init(
    classroomResources: .init(),
    courseResources: .init(),
    contentResources: .init(),
    laboratoryResources: .init(),
    memberResources: .init(),
    topResources: .init()
  )

  private init() {}
}
```
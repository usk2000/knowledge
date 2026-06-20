# Android Local AAR問題


[Error building Android library: Direct local .aar file dependencies are not supported - Stack Overflow](https://stackoverflow.com/questions/60878599/error-building-android-library-direct-local-aar-file-dependencies-are-not-supp)

> Direct local .aar file dependencies are not supported when building an AAR. 
> 


[How to manually include external aar package using Gradle for Android - Stack Overflow](https://stackoverflow.com/questions/16682847/how-to-manually-include-external-aar-package-using-gradle-for-android)

top-level gradle
```
flatDir {
  dirs project(":subproject").file("libs")
}
```

module gradle
```
 implementation(name:'library-name', ext:'aar')
```
# AdMob duplicated symbols


GoogleMobileAds.frameworkを複数追加していたから？
そうではなかった。


[ios - Duplicate symbols for architecture x86_64 under Xcode - Stack Overflow](https://stackoverflow.com/questions/24298144/duplicate-symbols-for-architecture-x86-64-under-xcode)

結局、２つファイルをプロジェクトに追加していた。

今回の場合、GDataXMLNode.m

```
duplicate symbol '_kGDataXMLXPathDefaultNamespacePrefix' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
duplicate symbol '_OBJC_CLASS_$_GDataXMLDocument' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
duplicate symbol '_OBJC_METACLASS_$_GDataXMLDocument' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
duplicate symbol '_OBJC_CLASS_$_GDataXMLElement' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
duplicate symbol '_OBJC_METACLASS_$_GDataXMLElement' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
duplicate symbol '_OBJC_CLASS_$_GDataXMLNode' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
duplicate symbol '_OBJC_METACLASS_$_GDataXMLNode' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
duplicate symbol '_OBJC_IVAR_$_GDataXMLNode.cachedAttributes_' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
duplicate symbol '_OBJC_IVAR_$_GDataXMLNode.cachedChildren_' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
duplicate symbol '_OBJC_IVAR_$_GDataXMLNode.cachedName_' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
duplicate symbol '_OBJC_IVAR_$_GDataXMLNode.xmlNode_' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
duplicate symbol '_OBJC_IVAR_$_GDataXMLNode.shouldFreeXMLNode_' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
duplicate symbol '_OBJC_IVAR_$_GDataXMLDocument.xmlDoc_' in:
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Intermediates.noindex/iPadMS2.build/iPadMS Sim Release-iphonesimulator/iPadMS2.build/Objects-normal/arm64/GDataXMLNode.o
    /Users/dev58-2/Library/Developer/Xcode/DerivedData/iPadMS2-ebuaarurrpdltnemdqfaesxnxsoi/Build/Products/iPhoneMS Sim Debug-iphonesimulator/libMHPSX.a(GDataXMLNode.o)
ld: 13 duplicate symbols for architecture arm64
```
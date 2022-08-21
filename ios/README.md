# Summary

Resources related to the mono iOS app can be found here.

## Getting started

Start by downloading [Xcode](https://developer.apple.com/xcode/) from the either the Mac App Store or the Xcode website.

Next, and before opening the iOS app project, install `xcodegen` with `brew`:

```bash
$ brew install xcodegen
```

Navigate to the iOS project root and generate an `xcodeproj` directory before finally opening Xcode and making changes:

```bash
$ cd ios/mono
$ xcodegen generate
```

In the future, modules may be modularized using different `xcodeproj` directories.

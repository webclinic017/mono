# Summary

Resources related to the Mono Android app can be found here.

## Structure

```
android
├── app
│   ├── proguard-rules.pro
│   ├── .gitignore
│   ├── BUILD.bazel
│   └── src
│       ├── androidTest
│       │   ├── BUILD.bazel
│       │   ├── AndroidManifest.xml
│       │   └── java
│       │       └── com.veganafro.app
│       │           └── ExampleInstrumentedTest.kt
│       ├── test
│       │   ├── BUILD.bazel
│       │   └── java
│       │       └── com.veganafro.app
│       │           └── ExampleUnitTest.kt
│       └── main
│           ├── AndroidManifest.xml
│           ├── java
│           │   └── com.veganafro.app
│           │       └── MainActivity.kt
│           └── res
│               ├── layout
│               │   └── activity_main.xml
│               └── values
│                   ├── colors.xml
│                   ├── strings.xml
│                   └── styles.xml 
├── .gitignore
└── WORKSPACE
```

Each feature should be a new module defined as a top level directory with a `BUILD` file. Each
module should follow the structure outlined above.

* androidTest
   
   `androidTest` contains tests that need the Android library and/or Robolectric to run, including
   `Activity` and `Fragment` tests that need to launch either component. Bazel doesn't currently
   support kt_android_local_test. So, the recommended best practice is to wrap a `kt_android_library`
   in an `android_local_test`.
* main
   
   `main` contains the module's source code.
* test
   
   `test` contains unit tests that can be run without the Android library and/or Robolectric,
   including `ViewModel` tests that focus on business logic.
 

## Getting started

### Setting up the dev environment

Assuming you've installed `brew` and `bazel`, run the following commands that install Java 8:

```bash
$ brew tap adoptopenjdk/openjdk
$ brew install --cask adoptopenjdk11
$ brew tap homebrew/core
```

Once those prerequisites have been installed, add the following line to `.bash_profile`:

```
export JAVA_HOME=$(/usr/libexec/java_home -v1.11)
```

Create a directory `~/android-sdk` and add the following lines to `.bash_profile`:

```bash
export ANDROID_HOME=~/android-sdk
export ANDROID_NDK_HOME=$ANDROID_HOME/ndk/21.3.6528147
export PATH=$JAVA_HOME/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin:$PATH
```

Now, download the Android SDK command line tools from [this](https://developer.android.com/studio) link. Extract those
tools from the zip file and navigate to `cmdline-tools/bin/`.

Run the following commands to install the required Android development tools:

```bash
$ ./sdkmanager --install "cmdline-tools;latest"
$ ./sdkmanager --install "platform-tools" "platforms;android-30" --sdk_root=~/android-sdk
$ ./sdkmanager --install "ndk;21.3.6528147" --sdk_root=~/android-sdk
$ ./sdkmanager --install "emulator" "patcher;v4" "sources;android-30" "build-tools;30.0.3" --sdk_root=~/android-sdk
```

Make sure that the tools were properly installed by running `sdkmanager --list`. Also verify that
nothing was installed twice through a hidden dependency.

### Running the app

After installing `bazel`, confirm that everything is working by navigating to the `android`
directory and executing:

```
$ bazel sync
$ bazel info workspace
$ bazel build //android/app:app_binary
```

If you see the current directory path printed, everything is working correctly.

Now, follow these steps to correctly configure Android Studio:

   1. Download Android Studio 2021.1.1 from [here](https://developer.android.com/studio/archive)
   1. Open the installer and move Android Studio to `Applications`
   1. Before setting up, install the `Bazel` plugin (try Command-Comma to open preferences)
   1. After restarting, begin setting up with custom settings:
      * The IDE JDK should be the path printed by `$ echo $JAVA_HOME`
      * The Android SDK location should be `~/android-sdk`
   1. When that's done, import the import the bazel project located at `android/.bazelproject`

Once that step is complete, it should be easy enough to build and install the app to a connected
device (if needed, use the AVD Manager to install an emulator):

```bash
$ bazel mobile-install //android/app:app_binary --start_app
```

Incremental builds can be sped up by executing the second command with a replaced target (the target
that has been modified) and an additional `--incremental` flag.

### Testing

Each module should be well tested, and tests can be executed with this `bazel` command:

```
$ bazel test //some/target:name
```

Each tested class corresponds to a `kt_jvm_test` (for unit tests) or an `android_local_test` (for
integration tests).

## Helpful notes

[Failing to run d8_dexbuilder with buildtools 31](https://github.com/bazelbuild/bazel/issues/13989)

[IntelliJ with Bazel](https://ij.bazel.build/docs/project-views.html)

[Use Java 11 source code in your project](https://developer.android.com/studio/releases/gradle-plugin?buildsystem=ndk-build#java-11)

[Android SDK Command-Line Tools release notes](https://developer.android.com/studio/releases/cmdline-tools)

[`sdkmanager` documentation](https://developer.android.com/studio/command-line/sdkmanager)

[SDK Platform Tools release notes](https://developer.android.com/studio/releases/platform-tools)

[SDK Build Tools release notes](https://developer.android.com/studio/releases/build-tools)

[SDK Platform release notes](https://developer.android.com/studio/releases/platforms)

Running `$ sdkmanager --list` should show something like:

```bash
 Path                                                  | Version      | Description                                     | Location
  -------                                               | -------      | -------                                         | -------
  build-tools;29.0.2                                    | 29.0.2       | Android SDK Build-Tools 29.0.2                  | build-tools/29.0.2
  build-tools;30.0.3                                    | 30.0.3       | Android SDK Build-Tools 30.0.3                  | build-tools/30.0.3
  build-tools;33.0.0                                    | 33.0.0       | Android SDK Build-Tools 33                      | build-tools/33.0.0
  cmdline-tools;latest                                  | 7.0          | Android SDK Command-line Tools (latest)         | cmdline-tools/latest
  emulator                                              | 31.2.10      | Android Emulator                                | emulator
  extras;android;m2repository                           | 47.0.0       | Android Support Repository                      | extras/android/m2repository
  extras;google;m2repository                            | 58           | Google Repository                               | extras/google/m2repository
  extras;intel;Hardware_Accelerated_Execution_Manager   | 7.6.5        | Intel x86 Emulator Accelerator (HAXM installer) | extras/intel/Hardware_Accelerated_Execution_Manager
  ndk;21.3.6528147                                      | 21.3.6528147 | NDK (Side by side) 21.3.6528147                 | ndk/21.3.6528147
  ndk;24.0.8215888                                      | 24.0.8215888 | NDK (Side by side) 24.0.8215888                 | ndk/24.0.8215888
  patcher;v4                                            | 1            | SDK Patch Applier v4                            | patcher/v4
  platform-tools                                        | 33.0.2       | Android SDK Platform-Tools                      | platform-tools
  platforms;android-29                                  | 5            | Android SDK Platform 29                         | platforms/android-29
  platforms;android-30                                  | 3            | Android SDK Platform 30                         | platforms/android-30
  platforms;android-32                                  | 1            | Android SDK Platform 32                         | platforms/android-32
  sources;android-29                                    | 1            | Sources for Android 29                          | sources/android-29
  sources;android-30                                    | 1            | Sources for Android 30                          | sources/android-30
  sources;android-32                                    | 1            | Sources for Android 32                          | sources/android-32
  system-images;android-30;google_apis_playstore;x86_64 | 10           | Google Play Intel x86 Atom_64 System Image      | system-images/android-30/google_apis_playstore/x86_64
```

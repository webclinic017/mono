"""
Dependencies that are needed for Android development
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@rules_jvm_external//:defs.bzl", "maven_install")

def android_deps():
    """
    Fetches required dependencies for Android development
    """

    RULES_ANDROID_VERSION = "0.1.1"
    RULES_ANDROID_SHA = "cd06d15dd8bb59926e4d65f9003bfc20f9da4b2519985c27e190cddc8b7a7806"

    http_archive(
        name = "build_bazel_rules_android",
        sha256 = RULES_ANDROID_SHA,
        strip_prefix = "rules_android-%s" % RULES_ANDROID_VERSION,
        type = "zip",
        urls = ["https://github.com/bazelbuild/rules_android/archive/v%s.zip" % RULES_ANDROID_VERSION],
    )

    RULES_KOTLIN_VERSION = "1.6.0"
    RULES_KOTLIN_SHA = "a57591404423a52bd6b18ebba7979e8cd2243534736c5c94d35c89718ea38f94"

    http_archive(
        name = "io_bazel_rules_kotlin",
        sha256 = RULES_KOTLIN_SHA,
        urls = [
            "https://github.com/bazelbuild/rules_kotlin/releases/download/v%s/rules_kotlin_release.tgz" % RULES_KOTLIN_VERSION,
        ],
    )

    ROBOLECTRIC_VERSION = "4.8.1"
    ROBOLECTRIC_SHA = "95d61d6b94bd19b0d528e47a5c1e482f2b2c914438028e9465b7ebd026013672"

    http_archive(
        name = "robolectric",
        sha256 = ROBOLECTRIC_SHA,
        strip_prefix = "robolectric-bazel-%s" % ROBOLECTRIC_VERSION,
        urls = ["https://github.com/robolectric/robolectric-bazel/archive/%s.tar.gz" % ROBOLECTRIC_VERSION],
    )

    RULES_JVM_EXTERNAL_VERSION = "4.2"
    RULES_JVM_EXTERNAL_SHA = "cd1a77b7b02e8e008439ca76fd34f5b07aecb8c752961f9640dea15e9e5ba1ca"

    http_archive(
        name = "rules_jvm_external",
        sha256 = RULES_JVM_EXTERNAL_SHA,
        strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_VERSION,
        urls = ["https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_VERSION],
    )

def maven_deps():
    maven_install(
        artifacts = [
            "androidx.appcompat:appcompat:1.3.0",
            "androidx.core:core-ktx:1.6.0",
            "androidx.constraintlayout:constraintlayout:2.0.4",
            "androidx.test:monitor:1.4.0",
            "androidx.test.espresso:espresso-core:3.4.0",
            "androidx.test.ext:junit:1.1.3",
            "junit:junit:4.13.2",
            "org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.7.0",
            "org.jetbrains.kotlin:kotlin-stdlib:1.7.0",
            "org.robolectric:robolectric:4.8.1",
        ],
        fetch_sources = True,
        repositories = [
            "https://maven.google.com",
            "https://repo1.maven.org/maven2",
        ],
    )

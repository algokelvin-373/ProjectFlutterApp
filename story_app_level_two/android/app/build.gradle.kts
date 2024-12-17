buildscript {
    val kotlin_version by extra("1.8.10")  // Define the Kotlin version using 'extra'
    dependencies {
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version")
    }
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.algokelvin.story_app_level_two"
    compileSdk = flutter.compileSdkVersion
     ndkVersion = flutter.ndkVersion
//    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.algokelvin.story_app_level_two"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        buildTypes {
            getByName("debug") {
                applicationIdSuffix = ".debug"
            }
            getByName("release") {

            }
        }
    }

    flavorDimensions.add("flavors")

    productFlavors {
        create("dev") {
            dimension = "flavors"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            applicationId = "com.algokelvin.story_app_level_two.dev"
        }
        create("prod") {
            dimension = "flavors"
            applicationId = "com.algokelvin.story_app_level_two"
        }
    }
}

dependencies {
    // Core library desugaring
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:1.2.2")

    // Optional dependencies for window support
    implementation("androidx.window:window:1.0.0")
    implementation("androidx.window:window-java:1.0.0")
}

flutter {
    source = "../.."
}

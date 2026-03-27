plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.aws_saa_trainer"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    flavorDimensions += "bank"

    productFlavors {
        create("saa") {
            dimension = "bank"
            applicationId = "com.example.aws_saa_trainer"
            manifestPlaceholders["appLabel"] = "SAA 练习"
        }
        create("sap") {
            dimension = "bank"
            applicationId = "com.example.aws_saa_trainer.sap"
            manifestPlaceholders["appLabel"] = "SAP 练习"
        }
        create("ispm") {
            dimension = "bank"
            applicationId = "com.example.aws_saa_trainer.ispm"
            manifestPlaceholders["appLabel"] = "ISPM 练习(实验)"
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.aws_saa_trainer"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

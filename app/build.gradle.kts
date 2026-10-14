plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "app.ipscanner"
    compileSdk = 34

    defaultConfig {
        applicationId = "app.ipradar"
        minSdk = 21          // Android 5.0 and newer
        targetSdk = 34
        // Every CI build gets a higher versionCode, so a new APK installs over the old one without "App not installed".
        versionCode = (System.getenv("GITHUB_RUN_NUMBER") ?: "1").toIntOrNull() ?: 1
        versionName = "1.0." + (System.getenv("GITHUB_RUN_NUMBER") ?: "1")
        // No native libraries -> one universal APK that runs on every CPU type (arm, arm64, x86, x86_64).
    }

    signingConfigs {
        create("release") {
            // Private key from GitHub Secrets when set (recommended); otherwise the bundled one.
            val ext = System.getenv("KEYSTORE_FILE")
            if (ext != null && file(ext).exists()) {
                storeFile = file(ext)
                storePassword = System.getenv("KEYSTORE_PASSWORD")
                keyAlias = System.getenv("KEY_ALIAS")
                keyPassword = System.getenv("KEY_PASSWORD")
            } else {
                storeFile = file("ipradar.jks")
                storePassword = "ipradar123"
                keyAlias = "ipradar"
                keyPassword = "ipradar123"
            }
            enableV1Signing = true
            enableV2Signing = true
            enableV3Signing = true
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            signingConfig = signingConfigs.getByName("release")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = "17" }

    lint { abortOnError = false; checkReleaseBuilds = false }
}

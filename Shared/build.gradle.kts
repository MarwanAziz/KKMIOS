import org.jetbrains.kotlin.gradle.plugin.mpp.BitcodeEmbeddingMode
import org.jetbrains.kotlin.gradle.plugin.mpp.NativeBuildType

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.kotlinCocoapods)
    alias(libs.plugins.androidLibrary)
}

kotlin {
    // Configure Android and iOS targets
    androidTarget {
        compilations.all {
            kotlinOptions {
                jvmTarget = "1.8"
            }
        }
    }
    iosX64()
    iosArm64()
    iosSimulatorArm64()

    // Configure CocoaPods settings
    cocoapods {
        version = "1.0"
        summary = "Some description for a Kotlin/Native module"
        homepage = "https://www.cocoapods.org"

        ios.deploymentTarget = "16.0"

        framework {
            baseName = "SharedLogic"
            isStatic = false
            embedBitcode(BitcodeEmbeddingMode.BITCODE)
        }

        // Define the podspec for CocoaPods
//        pod("Shared", null,  project.file("Shared.podspec"))

        // Optionally configure spec repositories if needed
        // specRepos {
        //     url("https://github.com/MarwanAziz/KKMIOS")
        // }

        xcodeConfigurationToNativeBuildType["CUSTOM_DEBUG"] = NativeBuildType.DEBUG
        xcodeConfigurationToNativeBuildType["CUSTOM_RELEASE"] = NativeBuildType.RELEASE
    }

    sourceSets {
        commonMain.dependencies {
            // Put your multiplatform dependencies here
        }
        commonTest.dependencies {
            implementation(libs.kotlin.test)
        }
    }
}

android {
    namespace = "com.example.kkmios"
    compileSdk = 34
    defaultConfig {
        minSdk = 23
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}
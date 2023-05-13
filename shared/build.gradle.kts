plugins {
    kotlin("multiplatform")
    kotlin("native.cocoapods")
    id("com.squareup.wire")
    id("com.android.library")
    kotlin("plugin.serialization") version "1.8.0"
}

sealed class Versions {
    companion object {
        const val coroutines = "1.6.4"
        const val koin = "3.3.2"
        const val serialization = "1.4.1"
        const val logback = "1.4.5"
        const val multiplatformSettings = "0.7.4"
        const val kermit = "1.2.2"
        const val wire = "4.5.5"
    }
}

kotlin {
    android()
    iosX64()
    iosArm64()
    iosSimulatorArm64()

    cocoapods {
        summary = "Some description for the Shared Module"
        homepage = "Link to the Shared Module homepage"
        version = "1.0"
        ios.deploymentTarget = "14.1"
        podfile = project.file("../iosApp/Podfile")
        framework {
            baseName = "shared"
        }
    }
    
    sourceSets {
        val commonMain by getting {
            dependencies {
                // Coroutines
                implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:${Versions.coroutines}")

                // serialization
                implementation("org.jetbrains.kotlinx:kotlinx-serialization-core:${Versions.serialization}")

                // koin
                implementation("io.insert-koin:koin-core:${Versions.koin}")

                // Other
                implementation("co.touchlab:kermit:1.0.0")
                implementation("ch.qos.logback:logback-classic:${Versions.logback}")

                implementation("com.russhwolf:multiplatform-settings:${Versions.multiplatformSettings}")
                implementation("com.russhwolf:multiplatform-settings-coroutines:1.0.0")

                // Wire
                implementation("com.squareup.wire:wire-grpc-client:${Versions.wire}")
                implementation("com.squareup.wire:wire-runtime:${Versions.wire}")

                implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.4.0")

            }
        }
        val commonTest by getting
        val androidMain by getting {
            dependencies {
                // Coroutines
                implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:${Versions.coroutines}")
            }
        }
        val androidTest by getting
        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by creating {
            dependsOn(commonMain)
            iosX64Main.dependsOn(this)
            iosArm64Main.dependsOn(this)
            iosSimulatorArm64Main.dependsOn(this)
            dependencies {

            }
        }
        val iosX64Test by getting
        val iosArm64Test by getting
        val iosSimulatorArm64Test by getting
        val iosTest by creating {
            dependsOn(commonTest)
            iosX64Test.dependsOn(this)
            iosArm64Test.dependsOn(this)
            iosSimulatorArm64Test.dependsOn(this)
        }
    }
}

@Suppress("UnstableApiUsage")
android {
    namespace = "com.app.flatter"
    compileSdk = 33
    defaultConfig {
        minSdk = 26
        targetSdk = 33
    }
}

dependencies {
    implementation("androidx.security:security-crypto-ktx:1.1.0-alpha05")
}

wire {
    sourcePath {
        srcDir("./src/proto")
    }
    kotlin {
        rpcRole = "client"
        rpcCallStyle = "suspending"
    }
}
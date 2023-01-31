plugins {
    kotlin("multiplatform")
    kotlin("native.cocoapods")
    id("com.squareup.sqldelight")
    id("com.android.library")
    kotlin("plugin.serialization") version "1.8.0"
}

sealed class Versions {
    companion object {
        const val coroutines = "1.6.4"
        const val ktor = "2.2.2"
        const val koin = "3.3.2"
        const val serialization = "1.4.1"
        const val sqlDelight = "1.5.5"
        const val logback = "1.4.5"
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

                // ktor
                implementation("io.ktor:ktor-client-core:${Versions.ktor}")
                implementation("io.ktor:ktor-client-logging:${Versions.ktor}")
                // https://ktor.io/docs/serialization-client.html
                implementation("io.ktor:ktor-client-content-negotiation:${Versions.ktor}")
                implementation("io.ktor:ktor-serialization-kotlinx-json:${Versions.ktor}")


                // serialization
                implementation("org.jetbrains.kotlinx:kotlinx-serialization-core:${Versions.serialization}")

                // SQLDelight
                implementation("com.squareup.sqldelight:runtime:${Versions.sqlDelight}")
                implementation("com.squareup.sqldelight:coroutines-extensions:${Versions.sqlDelight}")

                // koin
                implementation("io.insert-koin:koin-core:${Versions.koin}")

                // Other
                implementation("co.touchlab:kermit:1.0.0")
                implementation("ch.qos.logback:logback-classic:${Versions.logback}")
            }
        }
        val commonTest by getting
        val androidMain by getting {
            dependencies {
                // Coroutines
                implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:${Versions.coroutines}")

                // ktor
                implementation("io.ktor:ktor-client-android:${Versions.ktor}")

                // SQLDelight
                implementation("com.squareup.sqldelight:android-driver:${Versions.sqlDelight}")
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
                // ktor
                implementation("io.ktor:ktor-client-ios:${Versions.ktor}")

                // SQLDelight
                implementation("com.squareup.sqldelight:native-driver:${Versions.sqlDelight}")
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

android {
    namespace = "com.app.flatter"
    compileSdk = 32
    defaultConfig {
        minSdk = 26
        targetSdk = 32
    }
}

sqldelight {
    database("AppDatabase") {
        packageName = "tables"
        sourceFolders = listOf("sqldelight")
    }
}
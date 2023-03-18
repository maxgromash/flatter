plugins {
    id("com.android.application")
    kotlin("android")
}

@Suppress("UnstableApiUsage")
android {
    namespace = "com.app.flatter.android"
    compileSdk = 33
    defaultConfig {
        applicationId = "com.app.flatter.android"
        minSdk = 26
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
    }
    buildFeatures {
        viewBinding = true
    }
    packagingOptions {
        resources {
            excludes += "META-INF/INDEX.LIST"
        }
    }
    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
        }
    }
}

dependencies {
    //Modules
    implementation(project(":shared"))

    //Common
    implementation ("org.jetbrains.kotlin:kotlin-stdlib:1.8.10")
    implementation ("androidx.core:core-ktx:1.9.0")
    implementation ("androidx.appcompat:appcompat:1.6.1")
    implementation ("com.google.android.material:material:1.8.0")
    implementation("com.squareup.okhttp3:okhttp:4.10.0")
    implementation ("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation ("androidx.legacy:legacy-support-v4:1.0.0")
    implementation ("androidx.fragment:fragment-ktx:1.5.5")

    implementation("com.github.bumptech.glide:glide:4.12.0")

    // Wire
    implementation("com.squareup.wire:wire-grpc-client:4.2.0")
    implementation("com.squareup.wire:wire-runtime:4.2.0")

    // Jetpack
    implementation("androidx.lifecycle:lifecycle-viewmodel-ktx:2.6.0")
    implementation("androidx.lifecycle:lifecycle-livedata-ktx:2.6.0")

    //Navigation
    implementation("androidx.navigation:navigation-fragment-ktx:2.5.3")
    implementation("androidx.navigation:navigation-ui-ktx:2.5.3")

    // DI
    implementation("io.insert-koin:koin-android:3.3.2")
}
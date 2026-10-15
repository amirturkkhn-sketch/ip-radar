import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins { kotlin("jvm") version "2.0.20" }

kotlin { compilerOptions { jvmTarget.set(JvmTarget.JVM_17) } }
java { sourceCompatibility = JavaVersion.VERSION_17; targetCompatibility = JavaVersion.VERSION_17 }

// The scanning engine is shared with the Android app (pure JVM code).
val syncEngine by tasks.registering(Copy::class) {
    from("../app/src/main/java/app/ipscanner/Engine.kt")
    into(layout.buildDirectory.dir("generated/engine/app/ipscanner"))
}
sourceSets.main {
    kotlin.srcDir(layout.buildDirectory.dir("generated/engine"))
    resources.srcDir("../app/src/main/assets")   // the same index.html as the Android app
}
tasks.compileKotlin { dependsOn(syncEngine) }

tasks.jar {
    archiveFileName.set("ipradar.jar")
    manifest { attributes["Main-Class"] = "app.ipscanner.DesktopKt" }
}

// Everything jpackage needs in one folder: build/app/ipradar.jar + kotlin-stdlib.
tasks.register<Copy>("collect") {
    from(tasks.jar)
    from(configurations.runtimeClasspath)
    into(layout.buildDirectory.dir("app"))
}

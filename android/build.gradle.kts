allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    
    // Add namespace for plugins that don't have it specified
    afterEvaluate {
        if (hasProperty("android")) {
            val androidExtension = extensions.getByName("android")
            if (androidExtension is com.android.build.gradle.BaseExtension) {
                if (androidExtension.namespace == null) {
                    val manifestFile = file("src/main/AndroidManifest.xml")
                    if (manifestFile.exists()) {
                        val manifest = groovy.util.XmlSlurper().parse(manifestFile)
                        val packageName = manifest.getProperty("@package").toString()
                        if (packageName.isNotEmpty()) {
                            androidExtension.namespace = packageName
                            println("Setting namespace for ${project.name} to ${packageName}")
                        }
                    }
                }
            }
        }
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

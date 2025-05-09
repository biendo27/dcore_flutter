import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "flutter.base.dcore.dev"
            resValue(type = "string", name = "app_name", value = "DCore Dev")
            resValue(type = "string", name = "environment", value = "development")
            buildConfigField(type = "String", name = "APP_ENVIRONMENT", value = "\"dev\"")
            buildConfigField(type = "String", name = "API_BASE_URL", value = "\"https://dev.venusshop.top/api/v1\"")
            buildConfigField(type = "boolean", name = "IS_DEBUG", value = "true")
        }
        create("stg") {
            dimension = "flavor-type"
            applicationId = "flutter.base.dcore.stg"
            resValue(type = "string", name = "app_name", value = "DCore Staging")
            resValue(type = "string", name = "environment", value = "staging")
            buildConfigField(type = "String", name = "APP_ENVIRONMENT", value = "\"stg\"")
            buildConfigField(type = "String", name = "API_BASE_URL", value = "\"https://dev.venusshop.top/api/v1\"")
            buildConfigField(type = "boolean", name = "IS_DEBUG", value = "true")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "flutter.base.dcore"
            resValue(type = "string", name = "app_name", value = "DCore")
            resValue(type = "string", name = "environment", value = "production")
            buildConfigField(type = "String", name = "APP_ENVIRONMENT", value = "\"prod\"")
            buildConfigField(type = "String", name = "API_BASE_URL", value = "\"https://venusshop.top/api/v1\"")
            buildConfigField(type = "boolean", name = "IS_DEBUG", value = "false")
        }
    }

    buildFeatures.buildConfig = true
}
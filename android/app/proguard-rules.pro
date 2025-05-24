-keep class **.zego.** { *; }
-keep class **.**.zego_zpns.** { *; }
-dontwarn com.heytap.msp.push.HeytapPushManager
-dontwarn com.heytap.msp.push.callback.ICallBackResultService
-dontwarn com.heytap.msp.push.mode.DataMessage
-dontwarn com.heytap.msp.push.service.DataMessageCallbackService
-dontwarn com.huawei.hms.aaid.HmsInstanceId
-dontwarn com.huawei.hms.common.ApiException
-dontwarn com.huawei.hms.push.HmsMessageService
-dontwarn com.huawei.hms.push.RemoteMessage$Notification
-dontwarn com.huawei.hms.push.RemoteMessage
-dontwarn com.vivo.push.IPushActionListener
-dontwarn com.vivo.push.PushClient
-dontwarn com.vivo.push.PushConfig$Builder
-dontwarn com.vivo.push.PushConfig
-dontwarn com.vivo.push.listener.IPushQueryActionListener
-dontwarn com.vivo.push.model.UPSNotificationMessage
-dontwarn com.vivo.push.model.UnvarnishedMessage
-dontwarn com.vivo.push.sdk.OpenClientPushMessageReceiver
-dontwarn com.vivo.push.util.VivoPushException
-dontwarn com.xiaomi.mipush.sdk.MiPushClient
-dontwarn com.xiaomi.mipush.sdk.MiPushCommandMessage
-dontwarn com.xiaomi.mipush.sdk.MiPushMessage
-dontwarn com.xiaomi.mipush.sdk.PushMessageReceiver

#
# SPDX-FileCopyrightText: 2016, microG Project Team
# SPDX-License-Identifier: CC0-1.0

# Keep AutoSafeParcelables
-keep public class * extends org.microg.safeparcel.AutoSafeParcelable {
    @org.microg.safeparcel.SafeParcelable.Field *;
    @org.microg.safeparcel.SafeParceled *;
}

# Keep asInterface method cause it's accessed from SafeParcel
-keepattributes InnerClasses
-keepclassmembers interface * extends android.os.IInterface {
    public static class *;
}
-keep public class * extends android.os.Binder { public static *; }

-keep class com.zing.zalo.**{ *; }
-keep enum com.zing.zalo.**{ *; }
-keep interface com.zing.zalo.**{ *; }
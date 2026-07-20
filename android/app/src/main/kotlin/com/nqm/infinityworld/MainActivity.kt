package com.nqm.infinityworld

import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.BatteryManager
import android.os.Build
import android.os.SystemClock
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DEVICE_INFO_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getDeviceInfo" -> result.success(readDeviceInfo())
                    else -> result.notImplemented()
                }
            }
    }

    private fun readDeviceInfo(): Map<String, Any> {
        val batteryIntent = registerReceiver(
            null,
            IntentFilter(Intent.ACTION_BATTERY_CHANGED),
        )
        val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val glEsVersion = activityManager.deviceConfigurationInfo?.glEsVersion

        return mapOf(
            "javaVm" to valueOrUnavailable(System.getProperty("java.vm.name")),
            "openGlEs" to valueOrUnavailable(glEsVersion),
            "kernelArchitecture" to valueOrUnavailable(System.getProperty("os.arch")),
            "kernelVersion" to valueOrUnavailable(System.getProperty("os.version")),
            "uptimeMillis" to SystemClock.elapsedRealtime(),
            "rootAccess" to rootAccessHeuristic(),
            "googlePlayServices" to googlePlayServicesStatus(),
            "batteryHealth" to batteryHealth(batteryIntent),
            "batteryLevel" to batteryLevel(batteryIntent),
            "batteryPowerSource" to batteryPowerSource(batteryIntent),
            "batteryStatus" to batteryStatus(batteryIntent),
            "batteryTechnology" to batteryTechnology(batteryIntent),
            "batteryTemperature" to batteryTemperature(batteryIntent),
            "batteryVoltage" to batteryVoltage(batteryIntent),
            "batterySoc" to batterySoc(batteryIntent),
        )
    }

    private fun batteryHealth(intent: Intent?): String = when (
        intent?.getIntExtra(BatteryManager.EXTRA_HEALTH, -1)
    ) {
        BatteryManager.BATTERY_HEALTH_GOOD -> "Good"
        BatteryManager.BATTERY_HEALTH_OVERHEAT -> "Overheat"
        BatteryManager.BATTERY_HEALTH_DEAD -> "Dead"
        BatteryManager.BATTERY_HEALTH_OVER_VOLTAGE -> "Over voltage"
        BatteryManager.BATTERY_HEALTH_UNSPECIFIED_FAILURE -> "Unspecified failure"
        BatteryManager.BATTERY_HEALTH_COLD -> "Cold"
        else -> "Unavailable"
    }

    private fun batteryLevel(intent: Intent?): String {
        val level = intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val scale = intent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
        if (level < 0 || scale <= 0) return "Unavailable"
        return "${level * 100 / scale}%"
    }

    private fun batteryPowerSource(intent: Intent?): String = when (
        intent?.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1)
    ) {
        BatteryManager.BATTERY_PLUGGED_AC -> "AC"
        BatteryManager.BATTERY_PLUGGED_USB -> "USB"
        BatteryManager.BATTERY_PLUGGED_WIRELESS -> "Wireless"
        BatteryManager.BATTERY_PLUGGED_DOCK -> "Dock"
        0 -> "Battery"
        else -> "Unavailable"
    }

    private fun batteryStatus(intent: Intent?): String = when (
        intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
    ) {
        BatteryManager.BATTERY_STATUS_CHARGING -> "Charging"
        BatteryManager.BATTERY_STATUS_DISCHARGING -> "Discharging"
        BatteryManager.BATTERY_STATUS_FULL -> "Full"
        BatteryManager.BATTERY_STATUS_NOT_CHARGING -> "Not charging"
        else -> "Unavailable"
    }

    private fun batteryTechnology(intent: Intent?): String = valueOrUnavailable(
        intent?.getStringExtra(BatteryManager.EXTRA_TECHNOLOGY),
    )

    private fun batteryTemperature(intent: Intent?): String {
        val temperature = intent?.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, Int.MIN_VALUE)
        return if (temperature == null || temperature == Int.MIN_VALUE) {
            "Unavailable"
        } else {
            "${temperature / 10.0} C"
        }
    }

    private fun batteryVoltage(intent: Intent?): String {
        val voltage = intent?.getIntExtra(BatteryManager.EXTRA_VOLTAGE, -1) ?: -1
        return if (voltage < 0) "Unavailable" else "$voltage mV"
    }

    private fun batterySoc(intent: Intent?): String {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as? BatteryManager
        val capacity = batteryManager?.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        if (capacity != null && capacity in 0..100) return "$capacity%"
        return batteryLevel(intent)
    }

    private fun rootAccessHeuristic(): String {
        val commonSuPaths = listOf(
            "/system/bin/su",
            "/system/xbin/su",
            "/sbin/su",
            "/su/bin/su",
        )
        val hasTestKeys = Build.TAGS?.contains("test-keys") == true
        val hasSuBinary = commonSuPaths.any { File(it).exists() }
        return if (hasTestKeys || hasSuBinary) {
            "Possible root (heuristic)"
        } else {
            "Not detected (heuristic)"
        }
    }

    private fun googlePlayServicesStatus(): String = try {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            packageManager.getApplicationInfo(
                "com.google.android.gms",
                PackageManager.ApplicationInfoFlags.of(0),
            )
        } else {
            @Suppress("DEPRECATION")
            packageManager.getApplicationInfo("com.google.android.gms", 0)
        }
        "Installed"
    } catch (_: PackageManager.NameNotFoundException) {
        "Not installed"
    } catch (_: Exception) {
        "Unavailable"
    }

    private fun valueOrUnavailable(value: String?): String =
        if (value.isNullOrBlank()) "Unavailable" else value

    private companion object {
        const val DEVICE_INFO_CHANNEL = "infinity_world/device_info"
    }
}

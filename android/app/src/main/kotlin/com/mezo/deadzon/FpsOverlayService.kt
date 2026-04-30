package com.mezo.deadzon

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.graphics.PixelFormat
import android.os.Build
import android.os.IBinder
import android.os.SystemClock
import android.view.Gravity
import android.view.WindowManager
import android.widget.TextView
import androidx.core.app.NotificationCompat
import kotlin.math.roundToInt

class FpsOverlayService : Service() {
    companion object {
        private const val CHANNEL_ID = "deadzon_overlay_channel"
        private const val NOTIFICATION_ID = 9303
        private const val PREFS = "deadzon_overlay_prefs"
        private const val KEY_RUNNING = "fps_overlay_running"
    }

    private lateinit var wm: WindowManager
    private var overlayView: TextView? = null
    private var updater: Thread? = null
    @Volatile private var active = false

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        ensureForeground()
        val action = intent?.action
        if (action == "STOP") {
            stopSelf()
            return START_NOT_STICKY
        }
        showOverlay()
        return START_STICKY
    }

    private fun ensureForeground() {
        val nm = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(CHANNEL_ID, "FPS Overlay", NotificationManager.IMPORTANCE_LOW)
            nm.createNotificationChannel(channel)
        }
        val stopIntent = Intent(this, FpsOverlayService::class.java).apply { action = "STOP" }
        val pendingFlags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) PendingIntent.FLAG_IMMUTABLE else 0
        val pendingStop = PendingIntent.getService(this, 1, stopIntent, PendingIntent.FLAG_UPDATE_CURRENT or pendingFlags)
        val notification: Notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("FPS Overlay Running")
            .setContentText("Tap Stop to disable overlay")
            .setSmallIcon(android.R.drawable.ic_menu_view)
            .addAction(android.R.drawable.ic_menu_close_clear_cancel, "Stop", pendingStop)
            .setOngoing(true)
            .build()
        startForeground(NOTIFICATION_ID, notification)
    }

    private fun showOverlay() {
        if (overlayView != null) return
        wm = getSystemService(WINDOW_SERVICE) as WindowManager
        val prefs = getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val textView = TextView(this).apply {
            setTextColor(0xFFFFFFFF.toInt())
            setBackgroundColor(0x7F000000)
            setPadding(20, 12, 20, 12)
            textSize = 12f
        }
        val params = WindowManager.LayoutParams(
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.WRAP_CONTENT,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY else WindowManager.LayoutParams.TYPE_PHONE,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL,
            PixelFormat.TRANSLUCENT
        )
        params.gravity = gravityFrom(prefs.getString("position", "topRight") ?: "topRight")
        params.x = 24
        params.y = 90
        wm.addView(textView, params)
        overlayView = textView
        prefs.edit().putBoolean(KEY_RUNNING, true).apply()

        active = true
        updater = Thread {
            var frames = 0
            var last = SystemClock.elapsedRealtime()
            while (active) {
                frames += 1
                Thread.sleep(16)
                val now = SystemClock.elapsedRealtime()
                if (now - last >= 1000L) {
                    val fps = (frames * 1000f / (now - last)).roundToInt()
                    frames = 0
                    last = now
                    val cpuText = if (prefs.getBoolean("showCpuInfo", false)) " | CPU ${readCpuLoad()}" else ""
                    val appName = if (prefs.getBoolean("showAppName", false)) applicationInfo.loadLabel(packageManager).toString() else ""
                    val packageName = if (prefs.getBoolean("showPackageName", false)) this.packageName else ""
                    val label = if (prefs.getBoolean("showFpsLabel", true)) "FPS " else ""
                    val fpsBody = if (prefs.getBoolean("showFps", true)) "$label$fps" else ""
                    val body = buildString {
                        if (prefs.getBoolean("reverseFormat", false)) {
                            if (packageName.isNotEmpty()) append(packageName).append(" ")
                            if (appName.isNotEmpty()) append(appName).append(" ")
                            append(fpsBody)
                        } else {
                            append(fpsBody)
                            if (appName.isNotEmpty()) append(" ").append(appName)
                            if (packageName.isNotEmpty()) append(" ").append(packageName)
                        }
                        append(cpuText)
                    }.trim()
                    overlayView?.post { overlayView?.text = body.ifBlank { "Overlay active" } }
                }
            }
        }.apply { start() }
    }

    private fun gravityFrom(position: String): Int = when (position) {
        "topLeft" -> Gravity.TOP or Gravity.START
        "topCenter" -> Gravity.TOP or Gravity.CENTER_HORIZONTAL
        "bottomLeft" -> Gravity.BOTTOM or Gravity.START
        else -> Gravity.TOP or Gravity.END
    }

    private fun readCpuLoad(): String {
        return try {
            val load = java.lang.Runtime.getRuntime().availableProcessors()
            "${load}c"
        } catch (_: Exception) {
            "n/a"
        }
    }

    override fun onDestroy() {
        active = false
        updater?.interrupt()
        updater = null
        overlayView?.let { wm.removeView(it) }
        overlayView = null
        getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit().putBoolean(KEY_RUNNING, false).apply()
        super.onDestroy()
    }
}

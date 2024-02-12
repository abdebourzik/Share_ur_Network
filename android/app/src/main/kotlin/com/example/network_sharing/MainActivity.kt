package com.example.network_sharing

import android.os.Handler
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import golib.Golib
import java.util.Timer
import kotlin.concurrent.timer

class MainActivity : FlutterActivity() {
    private val channel = "santage"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "connect" -> {
                    val add = call.argument<String>("address") ?: "204.12.218.221:443"
                    Golib.start(add)
                }
                else -> result.notImplemented()
            }
        }
    }
}
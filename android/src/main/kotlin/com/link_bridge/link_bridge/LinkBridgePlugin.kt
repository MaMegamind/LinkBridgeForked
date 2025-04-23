package com.link_bridge.link_bridge

import android.app.Activity
import android.content.Intent
import android.net.Uri
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class LinkBridgePlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
  private lateinit var channel: MethodChannel
  private var activity: Activity? = null
  private var initialLink: String? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "deeplink_channel")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "onInitialLink" -> {
        result.success(initialLink)
      }

        "getInstallReferrer" -> {
            val context = activity?.applicationContext
            if (context != null) {
                InstallReferrerHandler(context).getInstallReferrer { referrer ->
                    result.success(referrer)
                }
            } else {
                result.error("UNAVAILABLE", "Context is not available", null)
            }
        }

      else -> result.notImplemented()
    }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    handleIntent(activity?.intent)
    binding.addOnNewIntentListener {
      handleIntent(it)
      false
    }
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    handleIntent(activity?.intent)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  private fun handleIntent(intent: Intent?) {
    val data: Uri? = intent?.data
    if (data != null) {
      val link = data.toString()
      initialLink = link
      channel.invokeMethod("onLinkReceived", link)
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

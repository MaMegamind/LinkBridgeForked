package com.link_bridge.link_bridge

import android.content.Context
import android.util.Log
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import com.android.installreferrer.api.ReferrerDetails
import android.content.SharedPreferences


class InstallReferrerHandler(private val context: Context) {

    private var referrerClient: InstallReferrerClient? = null
    private val prefs: SharedPreferences = context.getSharedPreferences("link_bridge", Context.MODE_PRIVATE)


    fun getInstallReferrer(onResult: (String?) -> Unit) {

        val alreadyHandled = prefs.getBoolean("install_referrer_handled", false)
        if (alreadyHandled) {
            onResult(null)
            return
        }

        referrerClient = InstallReferrerClient.newBuilder(context).build()
        referrerClient?.startConnection(object : InstallReferrerStateListener {
            override fun onInstallReferrerSetupFinished(responseCode: Int) {
                when (responseCode) {
                    InstallReferrerClient.InstallReferrerResponse.OK -> {
                        val response: ReferrerDetails = referrerClient!!.installReferrer
                        val referrerUrl = response.installReferrer
                        prefs.edit().putBoolean("install_referrer_handled", true).apply()
                        onResult(referrerUrl)
                        referrerClient?.endConnection()
                    }
                    InstallReferrerClient.InstallReferrerResponse.FEATURE_NOT_SUPPORTED,
                    InstallReferrerClient.InstallReferrerResponse.SERVICE_UNAVAILABLE -> {
                        onResult(null)
                    }
                }
            }
            override fun onInstallReferrerServiceDisconnected() {}
        })
    }
}

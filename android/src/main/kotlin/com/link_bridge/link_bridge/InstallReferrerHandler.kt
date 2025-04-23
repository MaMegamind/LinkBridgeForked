package com.link_bridge.link_bridge

import android.content.Context
import android.util.Log
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import com.android.installreferrer.api.ReferrerDetails

class InstallReferrerHandler(private val context: Context) {

    private var referrerClient: InstallReferrerClient? = null

    fun getInstallReferrer(onResult: (String?) -> Unit) {
        referrerClient = InstallReferrerClient.newBuilder(context).build()
        referrerClient?.startConnection(object : InstallReferrerStateListener {
            override fun onInstallReferrerSetupFinished(responseCode: Int) {
                when (responseCode) {
                    InstallReferrerClient.InstallReferrerResponse.OK -> {
                        val response: ReferrerDetails = referrerClient!!.installReferrer
                        val referrerUrl = response.installReferrer
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

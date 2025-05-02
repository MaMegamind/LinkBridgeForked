package com.link_bridge.link_bridge

import okhttp3.OkHttpClient
import okhttp3.Request
import java.io.IOException
import kotlin.concurrent.thread

class HttpReq {
    fun getLinkInfoAsync(linkId: String, callback: (String?) -> Unit) {
        thread {
            val client = OkHttpClient()
            val request = Request.Builder()
                .url("https://linkbridge.chimeratechsolutions.com/link_info/$linkId")
                .get()
                .build()

            try {
                val response = client.newCall(request).execute()
                if (!response.isSuccessful) throw IOException("Unexpected code $response")
                val body = response.body?.string()
                callback(body)
            } catch (e: Exception) {
                e.printStackTrace()
                callback(null)
            }
        }
    }
}

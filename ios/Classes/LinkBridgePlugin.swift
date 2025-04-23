import Flutter
import UIKit

public class DeepLink {
  static public let shared = DeepLinkPlugin()
  private init() {}
}

public final class DeepLinkPlugin: NSObject, FlutterPlugin {
  private var methodChannel: FlutterMethodChannel?

  private var initialLink: String?
  private var latestLink: String?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let methodChannel = FlutterMethodChannel(name: "deeplink_channel", binaryMessenger: registrar.messenger())

    let instance = DeepLink.shared
    instance.methodChannel = methodChannel

    registrar.addMethodCallDelegate(instance, channel: methodChannel)
    registrar.addApplicationDelegate(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if(call.method == "onInitialLink"){
       result(initialLink)
      }else{
      result(FlutterMethodNotImplemented)
      }
  }


  public func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([Any]) -> Void
  ) -> Bool {
    if let url = userActivity.webpageURL {
      handleLink(url: url)
    }
    return true
  }

  private func handleLink(url: URL) {
    let link = url.absoluteString
    latestLink = link

    if initialLink == nil {
      initialLink = link
    }

    methodChannel?.invokeMethod("onLinkReceived", arguments: link)
  }
}

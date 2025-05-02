import Flutter
import UIKit

public class LinkBridge {
  static public let shared = LinkBridgePlugin()
  private init() {}
}

public final class LinkBridgePlugin: NSObject, FlutterPlugin {
  private var methodChannel: FlutterMethodChannel?

  private var initialLink: String?
  private var latestLink: String?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let methodChannel = FlutterMethodChannel(name: "deeplink_channel", binaryMessenger: registrar.messenger())

    let instance = LinkBridge.shared
    instance.methodChannel = methodChannel

    registrar.addMethodCallDelegate(instance, channel: methodChannel)
    registrar.addApplicationDelegate(instance)
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "onInitialLink":
            result(initialLink)

        case "getLinkInfo":
            guard let args = call.arguments as? [String: Any],
                  let linkId = args["linkId"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing linkId", details: nil))
                return
            }

            fetchLinkInfo(linkId: linkId, result: result)

        default:
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
    
    private func fetchLinkInfo(linkId: String, result: @escaping FlutterResult) {
        let urlString = "https://linkbridge.chimeratechsolutions.com/link_info/\(linkId)"
        guard let url = URL(string: urlString) else {
            result(FlutterError(code: "INVALID_URL", message: "Invalid URL", details: nil))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                result(FlutterError(code: "HTTP_ERROR", message: error.localizedDescription, details: nil))
                return
            }

            guard let data = data,
                  let responseString = String(data: data, encoding: .utf8) else {
                result(FlutterError(code: "DATA_ERROR", message: "Invalid response", details: nil))
                return
            }

            result(responseString)
        }

        task.resume()
    }

}

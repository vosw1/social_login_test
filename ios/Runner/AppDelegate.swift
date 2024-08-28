import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Naver Third Party Login 초기화
    let thirdConn = NaverThirdPartyLoginConnection.getSharedInstance()
    thirdConn?.isNaverOauthEnable = true
    thirdConn?.isInAppOauthEnable = true

    // 서비스 파라미터 설정
    thirdConn?.serviceUrlScheme = "socaillogin"
    thirdConn?.consumerKey = "mlwJlo7cWuSqQjBF09JL"
    thirdConn?.consumerSecret = "E4RAP0401T"
    thirdConn?.serviceAppName = "studyapp"

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    var applicationResult = false
    if (!applicationResult) {
       applicationResult = NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
    }
    // if you use other application url process, please add code here.

    if (!applicationResult) {
       applicationResult = super.application(app, open: url, options: options)
    }
    return applicationResult
 }
}
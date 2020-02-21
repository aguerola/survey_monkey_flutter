import Flutter
import UIKit
//import SurveyMonkeyiOSSDK

public class SwiftSurveyMonkeyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "survey_monkey", binaryMessenger: registrar.messenger())
    let instance = SwiftSurveyMonkeyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "startSMFeedback"){
          //  var v: SMFeedbackViewController ;
        //SurveyMonkeyiOSSDK()
        /*let vc = SurveyViewController()
        vc.surveyHash = "self.surveyId" //set dynamically
        vc.player = self //set the object needed to access swift func
        self.view.addSubview(vc.view)*/
    }
    result("iOS " + UIDevice.current.systemVersion)
  }
}

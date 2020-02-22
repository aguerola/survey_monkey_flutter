import Flutter
import UIKit
//import SurveyMonkeyiOSSDK

public class SwiftSurveyMonkeyPlugin: NSObject, FlutterPlugin, SMFeedbackDelegate {
    var uiViewController: UIViewController?
    init(uiViewController: UIViewController?) {
        self.uiViewController = uiViewController
    }
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "survey_monkey", binaryMessenger: registrar.messenger())
    
    let uiViewController: UIViewController? =
    (UIApplication.shared.delegate?.window??.rootViewController);
    let instance = SwiftSurveyMonkeyPlugin(uiViewController: uiViewController)
    
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    var result: FlutterResult?
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "startSMFeedback"){
        self.result = result
        let collector = (call.arguments as? Dictionary<String, AnyObject>)?.self["collector"]
        let v: SMFeedbackViewController = SMFeedbackViewController(survey: collector as? String );
        v.delegate = self

        v.present(from: uiViewController, animated: true, completion: nil)

    }
    
  }
    
    public func respondentDidEndSurvey(_ respondent: SMRespondent!, error: Error!) {
        if(respondent != nil) {
            let questionResponse = respondent.questionResponses[0]
            print(questionResponse)
           result?.self(true)
        }else{
            let smError = error as? SMError
            let code = smError?.code ?? -100
            if(code == ERROR_CODE_RESPONSE_LIMIT_HIT || code == ERROR_CODE_RETRIEVING_RESPONSE) {
                result?.self(true)
            } else{
                result?.self(false)
            }
            print(error ?? "")
        }
    }
}

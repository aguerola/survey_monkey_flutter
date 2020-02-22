import Flutter
import UIKit
//import SurveyMonkeyiOSSDK

public class SwiftSurveyMonkeyPlugin: UIViewController, FlutterPlugin {
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "survey_monkey", binaryMessenger: registrar.messenger())
    let instance = SwiftSurveyMonkeyPlugin()
    
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print("lalala")
    if(call.method == "startSMFeedback"){
        let v: SMFeedbackViewController = SMFeedbackViewController(survey: "Q5DD86R");
        //v.delegate = self
        //v.scheduleIntercept(from: self, withAppTitle: "Lo que sea")
        v.present(from: self, animated: true) {
            print("lalala 2")
            result(true)
        }
        /*let vc = SurveyViewController()
        vc.surveyHash = "self.surveyId" //set dynamically
        vc.player = self //set the object needed to access swift func
        self.view.addSubview(vc.view)*/
    }
    
  }
    
    
    public func respondentDidEndSurvey(_ respondent: SMRespondent!, error: Error!) {
      
    }
}

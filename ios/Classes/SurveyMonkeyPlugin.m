#import "SurveyMonkeyPlugin.h"
#if __has_include(<survey_monkey/survey_monkey-Swift.h>)
#import <survey_monkey/survey_monkey-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "survey_monkey-Swift.h"
#endif

@implementation SurveyMonkeyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSurveyMonkeyPlugin registerWithRegistrar:registrar];
}
@end

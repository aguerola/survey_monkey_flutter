import 'dart:async';

import 'package:flutter/services.dart';

class SurveyMonkey {
  static const MethodChannel _channel =
      const MethodChannel('survey_monkey');

  static Future<bool> startSMFeedback(String collector) async {
    final bool surveyFinished = await _channel.invokeMethod('startSMFeedback',  {"collector":collector});
    return surveyFinished;
  }
}

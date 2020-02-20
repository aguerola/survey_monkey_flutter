package es.amg.survey_monkey

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import com.surveymonkey.surveymonkeyandroidsdk.SurveyMonkey
import com.surveymonkey.surveymonkeyandroidsdk.utils.SMError
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar


/** SurveyMonkeyPlugin */
class SurveyMonkeyPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(flutterPluginBinding.binaryMessenger, "survey_monkey")
        channel.setMethodCallHandler(SurveyMonkeyPlugin())
    }

    constructor()

    constructor(registrar: Registrar) : this() {
        activity = registrar.activity()
        registrar.addActivityResultListener(this)
    }


    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        const val REQUEST_CODE = 12342545
        private var activity: Activity? = null
        private var result: Result? = null
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "survey_monkey")
            channel.setMethodCallHandler(SurveyMonkeyPlugin(registrar))
        }
    }

    private val sdkInstance = SurveyMonkey()

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "startSMFeedback") {
            val arguments: Map<String, Any> = call.arguments as Map<String, Any>
            val collector: String = arguments["collector"] as String
            
            sdkInstance.startSMFeedbackActivityForResult(activity, REQUEST_CODE, collector)
            SurveyMonkeyPlugin.result = result
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }


    /**
     *   ActivityAware implementation
     *   start
     */

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        //binding.addActivityResultListener(this)
    }


    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    /**
     *   ActivityAware implementation
     *   end
     */


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {

        Log.wtf("SurveyMonkeyPlugin", "resultCode: $resultCode")
        /*data?.extras?.keySet()?.forEach {
            Log.wtf("SurveyMonkeyPlugin", "$it = ${data.extras[it]}")

        }*/

        if (requestCode == REQUEST_CODE) {
            val surveyFinished: Boolean
            surveyFinished = if (resultCode == Activity.RESULT_OK) {
                true
            } else {
                val extras = data?.extras
                extras != null && extras["smErrorCode"] == SMError.ErrorType.ERROR_CODE_RESPONSE_LIMIT_HIT.value
            }

            result?.success(surveyFinished)
            result = null
            return true
        }

        return false
    }
}

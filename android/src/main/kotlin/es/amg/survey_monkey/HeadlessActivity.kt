package es.amg.survey_monkey

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import com.surveymonkey.surveymonkeyandroidsdk.SurveyMonkey


class HeadlessActivity : Activity() {
    private val sdkInstance = SurveyMonkey()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val collector = intent.getStringExtra("collector")
        sdkInstance.startSMFeedbackActivityForResult(this,  1234, collector)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        
        setResult(RESULT_OK, data)
        finish()
    }
}
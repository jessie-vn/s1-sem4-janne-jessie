package nl.jobr

import android.os.Bundle
import android.text.InputType
import android.util.Log
import android.view.View
import android.webkit.WebView
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import com.google.android.material.bottomnavigation.BottomNavigationView
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import nl.jobr.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val navView: BottomNavigationView = binding.navView

        val navController = findNavController(R.id.nav_host_fragment_activity_main)
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        val appBarConfiguration = AppBarConfiguration(
            setOf(
                R.id.navigation_home, R.id.navigation_dashboard, R.id.navigation_notifications
            )
        )
        setupActionBarWithNavController(navController, appBarConfiguration)
        navView.setupWithNavController(navController)
    }
    private var idx: Int = 1;
    private data class Question(val question1: String, val type1: Int, var answer1: String?, val question2: String, val type2: Int, var answer2: String?)
    private val questions = arrayOf(
        Question("What is your name?", InputType.TYPE_CLASS_TEXT, null,"What is your age?", InputType.TYPE_CLASS_NUMBER, null),
        Question("What company are you currently working for?", InputType.TYPE_CLASS_TEXT, null,"What companies have you worked for?", InputType.TYPE_CLASS_TEXT, null),
        Question("How long have you worked for your current company?", InputType.TYPE_CLASS_TEXT, null,"What skills do you have?", InputType.TYPE_CLASS_TEXT, null)
    )
    fun continueSurvey(view: View) {
        for (i in idx until questions.size) {
            updateQuestions(idx)
            break
        }
        idx++

        // Check if last question is already displayed
        if (idx > questions.size) {
            Toast.makeText(getBaseContext(), "Your resume has been updated", Toast.LENGTH_SHORT ).show();
            idx = 0;
            updateQuestions(idx)
            idx = 1;
        }
    }
    private fun updateQuestions(i: Int) {
        val question1: TextView = findViewById(R.id.tvName)
        val type1: EditText = findViewById(R.id.tbName)
        val question2: TextView = findViewById(R.id.tvAge)
        val type2: EditText = findViewById(R.id.nbAge)

        // Clean Edit View
        type1.text = null
        type2.text = null

        if (questions[i].answer1 != null) { type1.hint = questions[i].answer1 }
        if (questions[i].answer2 != null) { type2.hint = questions[i].answer2 }

        question1.text = questions[i].question1
        type1.inputType = questions[i].type1
        questions[i].answer1 = type1.text.toString()

        question2.text = questions[i].question2
        type2.inputType = questions[i].type2
        questions[i].answer2 = type2.text.toString()
    }
}
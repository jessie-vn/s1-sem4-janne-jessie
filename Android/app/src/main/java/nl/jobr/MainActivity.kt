package nl.jobr

import android.os.Bundle
import android.text.InputType
import android.util.Log
import android.view.View
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import com.google.android.material.bottomnavigation.BottomNavigationView
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import nl.jobr.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var db: FirebaseDatabase
    private lateinit var reference: DatabaseReference

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val navView: BottomNavigationView = binding.navView

        val navController = findNavController(R.id.nav_host_fragment_activity_main)
        navController
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        val appBarConfiguration = AppBarConfiguration(
            setOf(
                R.id.navigation_resume, R.id.navigation_home, R.id.navigation_account
            )
        )
        setupActionBarWithNavController(navController, appBarConfiguration)
        navView.setupWithNavController(navController)
        navView.setSelectedItemId(R.id.navigation_home)
    }

    /* Survey btn Resume page */
    private var idx: Int = 0;
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
        //idx++

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

        if (type2.text != null) { questions[i].answer2 = type2.text.toString() }
        if (type1.text.trim().isNotEmpty())
        { questions[i].answer1 = type1.text.toString() }

        idx++
        if (idx >= questions.size) { idx = 0 }
        Log.d(idx.toString(), "IDX")
        Log.d(questions[idx].answer1, "Answer1")

        question1.text = questions[idx].question1
        type1.inputType = questions[idx].type1

        question2.text = questions[idx].question2
        type2.inputType = questions[idx].type2

        // Clean Edit View
        type1.text = null
        type1.hint = null
        type2.text = null
        type2.hint = null

        if (questions[idx].answer1 != null)
        { type1.hint = questions[idx].answer1 }
        if (questions[idx].answer2 != null) { type2.hint = questions[idx].answer2 }
    }

    /* Save button Account page */
    // Account gotten out of database if we had a login :)
    private val account: Account = Account(1,"Casey Web", null, null, null, null)
    fun saveInformation(view: View) {
        val name: EditText = findViewById(R.id.etName)
        val email: EditText = findViewById(R.id.etEmail)
        val phoneNumber: EditText = findViewById(R.id.etPhoneNumber)
        val occupation: EditText = findViewById(R.id.etOccupation)

        if (account != null) {
            if (name.text.trim().isNotEmpty()) { account.name = name.text.toString() }
            if (email.text.trim().isNotEmpty()) { account.email = email.text.toString() }
            if (phoneNumber.text.trim().isNotEmpty()) { account.phoneNumber = phoneNumber.text.toString() }
            if (occupation.text.trim().isNotEmpty()) { account.occupation = occupation.text.toString() }

            // Add changes to database
            if (name.text.trim().isNotEmpty() || email.text.trim().isNotEmpty() || phoneNumber.text.trim().isNotEmpty()
                || occupation.text.trim().isNotEmpty()) {
                db = FirebaseDatabase.getInstance()
                reference = db.getReference("Account")
                reference.child(account.id.toString() + ": " + account.name).setValue(account)
            }
            updateAccountBoxes()
            Toast.makeText(getBaseContext(), "Your information has been updated", Toast.LENGTH_SHORT ).show();
        }
    }
    private fun updateAccountBoxes() {
        val name: EditText = findViewById(R.id.etName)
        val email: EditText = findViewById(R.id.etEmail)
        val phoneNumber: EditText = findViewById(R.id.etPhoneNumber)
        val occupation: EditText = findViewById(R.id.etOccupation)

        if (account != null) {
            if (account.name != null) { name.hint = account.name }
            if (account.email != null) { email.hint = account.email }
            if (account.phoneNumber != null) { phoneNumber.hint = account.phoneNumber }
            if (account.occupation != null) { occupation.hint = account.occupation }
        }

        // Clean up boxes
        name.text = null
        email.text = null
        phoneNumber.text = null
        occupation.text = null
    }
}
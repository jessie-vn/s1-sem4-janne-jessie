package nl.jobr

import android.content.ContentValues.TAG
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
import com.google.firebase.database.*
import nl.jobr.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private val dataAccess : DataAccess = DataAccess()

    // Account and Resume gotten out of database if we had a login :)
    private var account: Account = Account()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        // Getting Account and Resume
        account = dataAccess.getAccountData()
        account.resume.addQuestions()
        account.resume.questions[0].answer = account.name

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

        val type1: EditText = findViewById(R.id.tbName)
        val type2: EditText = findViewById(R.id.nbAge)
        if (account.resume.questions[0].answer != null) {
            type1.hint = account.resume.questions[0].answer
        }
        if (account.resume.questions[1].answer != null) {
            type2.hint = account.resume.questions[1].answer
        }
    }

    /* Survey btn Resume page */
    private var idx: Int = 0;
    fun continueSurvey(view: View) {
        for (i in idx until account.resume.questions.size) {
            updateQuestions(idx, idx+1)
            dataAccess.updateResume(account.resume) // Add changes to database
            break
        }
        idx += 2

        // Check if last question is already displayed
        if (idx > account.resume.questions.size) {
            Toast.makeText(getBaseContext(), "Your resume has been updated", Toast.LENGTH_SHORT ).show();
            updateQuestions(0, 1)
            idx = 2;
        }
    }
    private fun updateQuestions(i1: Int, i2: Int) {
        val question1: TextView = findViewById(R.id.tvName)
        val type1: EditText = findViewById(R.id.tbName)
        val question2: TextView = findViewById(R.id.tvAge)
        val type2: EditText = findViewById(R.id.nbAge)

        if (type1.text.trim().isNotEmpty() && account.resume.questions[i1].answer != null) {
            account.resume.questions[i1].answer = type1.text.toString()
        }
        if (type2.text.trim().isNotEmpty() && account.resume.questions[i1].answer != null) {
            account.resume.questions[i2].answer = type2.text.toString()
        }

        // Clean Edit View
        type1.text = null
        type1.hint = null
        type2.text = null
        type2.hint = null

        Log.d(account.resume.questions.size.toString(), "Yes")
        if (i1+2 >= account.resume.questions.size && i1+2 >= account.resume.questions.size) {
            question1.text = account.resume.questions[0].question
            question2.text = account.resume.questions[1].question

            if (account.resume.questions[0].answer != null) {
                type1.hint = account.resume.questions[0].answer
            }
            if (account.resume.questions[1].answer != null) {
                type2.hint = account.resume.questions[1].answer
            }
        }
        else {
            question1.text = account.resume.questions[i1+2].question
            question2.text = account.resume.questions[i2+2].question

            if (account.resume.questions[i1 + 2].answer != null) {
                type1.hint = account.resume.questions[i1 + 2].answer
            }
            if (account.resume.questions[i2 + 2].answer != null) {
                type2.hint = account.resume.questions[i2 + 2].answer
            }
        }
    }

    /* Save button Account page */
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
                dataAccess.updateAccount(account)
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
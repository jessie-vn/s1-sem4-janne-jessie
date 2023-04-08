package nl.jobr

import android.opengl.Visibility
import android.os.Bundle
import android.text.InputType
import android.util.Log
import android.view.View
import android.widget.*
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
        navView.setSelectedItemId(R.id.navigation_home);

        // TextView displays selected age
        val ageSlider: SeekBar = findViewById(R.id.sbAge)
        val ageNumber: TextView = findViewById(R.id.tvSelectedAge)
        ageSlider.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(seekBar: SeekBar, progress: Int, fromUser: Boolean) {
                ageNumber.text = progress.toString()
            }

            override fun onStartTrackingTouch(seekBar: SeekBar) {}
            override fun onStopTrackingTouch(seekBar: SeekBar) {}
        })
    }

    /* Survey btn Resume page */
    fun continueSurvey(view: View) {
        val scrollView: ScrollView = findViewById(R.id.svResume)
        val completed: TextView = findViewById(R.id.tvCompleted)
        scrollView.visibility = View.GONE
        completed.visibility = View.VISIBLE
        Toast.makeText(getBaseContext(), "Your resume has been updated", Toast.LENGTH_SHORT ).show();
    }

    /* Save button Account page */
    private data class Person(var name: String, var email: String?, var phoneNumber: String?, var occupation: String?)
    private val person: Person = Person("Casey Web", null, null, null)
    fun saveInformation(view: View) {
        val name: EditText = findViewById(R.id.etName)
        val email: EditText = findViewById(R.id.etEmail)
        val phoneNumber: EditText = findViewById(R.id.etPhoneNumber)
        val occupation: EditText = findViewById(R.id.etOccupation)

        if (person != null) {
            if (name.text.trim().isNotEmpty()) { person.name = name.text.toString() }
            if (email.text.trim().isNotEmpty()) { person.email = email.text.toString() }
            if (phoneNumber.text.trim().isNotEmpty()) { person.phoneNumber = phoneNumber.text.toString() }
            if (occupation.text.trim().isNotEmpty()) { person.occupation = occupation.text.toString() }
            updateAccountBoxes()
            Toast.makeText(getBaseContext(), "Your information has been updated", Toast.LENGTH_SHORT ).show();
        }
    }
    private fun updateAccountBoxes() {
        val name: EditText = findViewById(R.id.etName)
        val email: EditText = findViewById(R.id.etEmail)
        val phoneNumber: EditText = findViewById(R.id.etPhoneNumber)
        val occupation: EditText = findViewById(R.id.etOccupation)

        if (person != null) {
            if (person.name != null) { name.hint = person.name }
            if (person.email != null) { email.hint = person.email }
            if (person.phoneNumber != null) { phoneNumber.hint = person.phoneNumber }
            if (person.occupation != null) { occupation.hint = person.occupation }
        }

        // Clean up boxes
        name.text = null
        email.text = null
        phoneNumber.text = null
        occupation.text = null
    }
}
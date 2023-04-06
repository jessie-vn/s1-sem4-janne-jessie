package nl.jobr

import android.content.ContentValues
import android.content.ContentValues.TAG
import android.util.Log
import com.google.firebase.database.*

class DataAccess {
    private var db: FirebaseDatabase = FirebaseDatabase.getInstance()
    private lateinit var reference: DatabaseReference

    fun getAccountData(): Account {
        var returnAccount = Account()
        // Get Account
        reference = db.getReference("account")
        reference.addValueEventListener(object : ValueEventListener {
            override fun onDataChange(dataSnapshot: DataSnapshot) {
                // Handle data change event
                for (userSnapshot in dataSnapshot.children) {
                    val account = userSnapshot.getValue(Account::class.java)
                    if (account != null) {
                        returnAccount = account
                    }
                    Log.d(account.toString(), "this is message")

                }
            }
            override fun onCancelled(error: DatabaseError) {
                // Handle error event
                Log.d(ContentValues.TAG, "onCancelled: ${error.message}")
            }
        })
        return returnAccount
    }

    fun updateResume(resume: Resume) {
        reference = db.getReference("account/0/resume/0")
        reference.child(resume.id.toString()).setValue(resume)
    }

    fun updateAccount(account: Account) {
        reference = db.getReference("account")
        reference.child(account.id.toString()).setValue(account)
    }
}
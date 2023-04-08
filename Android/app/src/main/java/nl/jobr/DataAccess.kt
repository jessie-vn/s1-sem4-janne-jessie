package nl.jobr

import android.R
import com.google.firebase.database.*


class DataAccess {
    private var db: FirebaseDatabase = FirebaseDatabase.getInstance()
    private lateinit var reference: DatabaseReference

    fun getAccountData(): Account {
        var returnAccount = Account()
        // Get Account
        reference = db.getReference("account")
        // TODO: Fix this error - Can't convert object of type java.util.ArrayList to type nl.jobr.Account
        reference.addValueEventListener(object : ValueEventListener {
            override fun onDataChange(dataSnapshot: DataSnapshot) {
                if (dataSnapshot.exists()) {
                    for (ds in dataSnapshot.getChildren()) {
                        val account = ds.getValue(Account::class.java)
                        if (account != null) { returnAccount = account }
                    }
                }
            }

            override fun onCancelled(databaseError: DatabaseError) {
                println("The read failed: " + databaseError.code)
            }
        })
        return returnAccount
    }

    fun updateResume(resume: Resume) {
        val id: Int = resume.id
        reference = db.getReference("account/0/resume/0")
        reference.child("$id-resume").setValue(resume)
    }

    fun updateAccount(account: Account) {
        val id: Int = account.id
        reference = db.getReference("account/0")
        reference.child("$id-account").setValue(account)
    }
}
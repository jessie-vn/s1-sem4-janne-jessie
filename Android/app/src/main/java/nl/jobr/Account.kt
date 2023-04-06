package nl.jobr

class Account()
{
    var id: Int = 0
    var name: String? = null
    var age: Int? = null
    var email: String? = null
    var phoneNumber: String? = null
    var occupation: String? = null
    var resume: Resume = Resume()
    constructor(id: Int, name: String?, age: Int?, email: String?, phoneNumber: String?, occupation: String?, resume: Resume): this() {
        this.id = id
        this.name = name
        this.age = age
        this.email = email
        this.phoneNumber = phoneNumber
        this.occupation = occupation
        this.resume = resume
    }
}
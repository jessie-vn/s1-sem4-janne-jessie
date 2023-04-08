package nl.jobr

import android.text.InputType

class Resume()
{
    var id: Int = 0
    var questions: ArrayList<Question> = ArrayList()

    constructor(id: Int, questions: ArrayList<Question>) : this() {
        this.id = id
        this.questions = questions
        addQuestions()
    }
    fun addQuestions() {
        questions.add(Question("what is your name?", null))
        questions.add(Question("What is your age?", null))
        questions.add(Question("What company are you currently working for?", null))
        questions.add(Question("What companies have you worked for?", null))
        questions.add(Question("How long have you worked for your current company?", null))
        questions.add(Question("What skills do you have?", null))
    }
}
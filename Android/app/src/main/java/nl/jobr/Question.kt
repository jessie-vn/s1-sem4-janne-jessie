package nl.jobr

class Question {
    var question: String = ""
    var answer: String? = null

    constructor(question: String, answer: String?) : this() {
        this.question = question
        this.answer = answer
    }

    constructor()
}
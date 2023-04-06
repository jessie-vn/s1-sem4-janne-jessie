package nl.jobr

class Resume()
{
    var id: Int = 0;
    var answers: Array<String> = emptyArray()

    constructor(id: Int, answers: Array<String>) : this() {
        this.id = id
        this.answers = answers
    }
}
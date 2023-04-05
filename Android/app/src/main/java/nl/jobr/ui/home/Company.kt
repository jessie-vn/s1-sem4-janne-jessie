package nl.jobr.ui.home

data class Company(
    val id: Long = counter++,
    val name: String,
    val city: String,
    val url: String
) {
    companion object {
        private var counter = 0L
    }
}
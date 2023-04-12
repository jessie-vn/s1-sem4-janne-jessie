package nl.jobr.ui.home

data class Company(
    val id: Long = counter++,
    val name: String,
    val openPosition: String,
    val city: String,
    val urls: List<String>,
    val hours: String
) {
    companion object {
        private var counter = 0L
    }
}
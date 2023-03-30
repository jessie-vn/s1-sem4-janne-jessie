package nl.jobr.ui.resume

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class ResumeViewModel : ViewModel() {

    private val _text = MutableLiveData<String>().apply {
        value = "This is resume Fragment"
    }
    val text: LiveData<String> = _text
}
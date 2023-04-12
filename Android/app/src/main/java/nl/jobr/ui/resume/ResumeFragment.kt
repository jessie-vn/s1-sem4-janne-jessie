package nl.jobr.ui.resume

import android.R
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.SeekBar
import android.widget.SeekBar.OnSeekBarChangeListener
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import nl.jobr.databinding.FragmentResumeBinding


class ResumeFragment : Fragment() {

    private var _binding: FragmentResumeBinding? = null

    // This property is only valid between onCreateView and
    // onDestroyView.
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        val resumeViewModel =
            ViewModelProvider(this).get(ResumeViewModel::class.java)

        _binding = FragmentResumeBinding.inflate(inflater, container, false)
        val root: View = binding.root

        val sbAge: SeekBar = binding.sbAge
        val progressLabel: TextView = binding.tvSelectedAge
        sbAge.setOnSeekBarChangeListener(object: OnSeekBarChangeListener {
            override fun onProgressChanged(p0: SeekBar?, p1: Int, p2: Boolean) {
                progressLabel.text = p1.toString()
            }
            override fun onStartTrackingTouch(p0: SeekBar?) {}
            override fun onStopTrackingTouch(p0: SeekBar?) {}
        })

        /*val textView: TextView = binding.textHome
        resumeViewModel.text.observe(viewLifecycleOwner) {
            textView.text = it
        }*/
        return root
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
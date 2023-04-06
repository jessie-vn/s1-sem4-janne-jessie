package nl.jobr.ui.home

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.animation.LinearInterpolator
import android.widget.ImageButton
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.DefaultItemAnimator
import androidx.recyclerview.widget.DiffUtil
import com.yuyakaido.android.cardstackview.*
import com.yuyakaido.android.cardstackview.CardStackView
import nl.jobr.R
import nl.jobr.databinding.FragmentMatchBinding
import com.yuyakaido.android.cardstackview.Direction


class MatchFragment : Fragment(), CardStackListener {

    private lateinit var btnDislike: ImageButton
    private lateinit var btnLike: ImageButton

    private lateinit var cardStackView : CardStackView
    private lateinit var manager: CardStackLayoutManager
    private lateinit var adapter: CardStackAdapter

    private var _binding: FragmentMatchBinding? = null

    // This property is only valid between onCreateView and
    // onDestroyView.
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {

        _binding = FragmentMatchBinding.inflate(inflater, container, false)
        val root: View = binding.root

        val context = requireContext()
        cardStackView = root.findViewById(R.id.card_stack_view)

        btnDislike = root.findViewById(R.id.btnDislike)
        btnLike = root.findViewById(R.id.btnLike)

        btnDislike.setOnClickListener {
            handler.postDelayed({ update(btnDislike) }, DELAY_TIME)
        }

        btnLike.setOnClickListener {
            handler.postDelayed({ update(btnLike) }, DELAY_TIME)
        }

        manager = CardStackLayoutManager(context, this)
        adapter = CardStackAdapter(createCompanies())

        cardStackView.layoutManager = manager
        cardStackView.adapter = adapter

        // Move this line after the manager property has been initialized
        setupCardStackView()

        return root
    }

    private fun update(button: View) {
                // Handle dislike button click
                manager.setSwipeAnimationSetting(
                    SwipeAnimationSetting.Builder()
                        .setDirection(if (button.id == R.id.btnLike) Direction.Right else Direction.Left)
                        .setDuration(Duration.Normal.duration)
                        .build())

                cardStackView.swipe()
        handler.postDelayed({ setupCardStackView() }, DELAY_TIME)
    }
    companion object {
        private const val DELAY_TIME = 100L
        private val handler = Handler(Looper.getMainLooper())
    }

    override fun onCardDragging(direction: Direction, ratio: Float) {
        Log.d("CardStackView", "onCardDragging: d = ${direction.name}, r = $ratio")
    }

    override fun onCardSwiped(direction: Direction) {
        Log.d("CardStackView", "onCardSwiped: p = ${manager.topPosition}, d = $direction")
        if (manager.topPosition == adapter.itemCount - 1) {
            paginate()
        }
    }

    override fun onCardRewound() {
        Log.d("CardStackView", "onCardRewound: ${manager.topPosition}")
    }

    override fun onCardCanceled() {
        Log.d("CardStackView", "onCardCanceled: ${manager.topPosition}")
    }

    override fun onCardAppeared(view: View, position: Int) {
        val textView = view.findViewById<TextView>(R.id.item_name)
        Log.d("CardStackView", "onCardAppeared: ($position) ${textView.text}")
    }

    override fun onCardDisappeared(view: View, position: Int) {
        val textView = view.findViewById<TextView>(R.id.item_name)
        Log.d("CardStackView", "onCardDisappeared: ($position) ${textView.text}")
    }

    private fun setupCardStackView() {
        initialize()
    }

    private fun initialize() {
        manager.setStackFrom(StackFrom.None)
        manager.setVisibleCount(3)
        manager.setTranslationInterval(8.0f)
        manager.setScaleInterval(0.95f)
        manager.setSwipeThreshold(0.3f)
        manager.setMaxDegree(20.0f)
        manager.setDirections(Direction.HORIZONTAL)
        manager.setCanScrollHorizontal(true)
        manager.setCanScrollVertical(true)
        manager.setSwipeableMethod(SwipeableMethod.AutomaticAndManual)
        manager.setOverlayInterpolator(LinearInterpolator())
        cardStackView.layoutManager = manager
        cardStackView.adapter = adapter
        cardStackView.itemAnimator.apply {
            if (this is DefaultItemAnimator) {
                supportsChangeAnimations = false
            }
        }
    }

    private fun paginate() {
        val old = adapter.getCompanies()
        val new = old.plus(createCompanies())
        if(new.isNotEmpty()){
            val callback = SpotDiffCallback(old, new)
            val result = DiffUtil.calculateDiff(callback)
            adapter.setCompanies(new)
            result.dispatchUpdatesTo(adapter)
        }
    }

    private fun createCompanies(): List<Company> {
        val companies = ArrayList<Company>()
        companies.add(Company(name = "Fontys Hogeschool", openPosition = "Teacher ICT Smart mobile", city = "Eindhoven", url = "https://yt3.googleusercontent.com/ytc/AL5GRJUei-YFtil1rTe6CsZ0v_ejWk2No8LKKQrHktewhg=s176-c-k-c0x00ffffff-no-rj"))
        companies.add(Company(name = "Hard Rock Cafe", openPosition = "Bartender", city = "Amsterdam", url = "https://d2q79iu7y748jz.cloudfront.net/s/_squarelogo/256x256/b98c482e48e4079242bfa8e3439699ad"))
        companies.add(Company(name = "WerkCentrale Nederland", openPosition = "Manager Customer Service", city = "Rozenburg", url = ""))
        return companies
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
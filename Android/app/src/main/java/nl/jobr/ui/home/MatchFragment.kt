package nl.jobr.ui.home

import android.content.res.ColorStateList
import android.graphics.Color
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.animation.LinearInterpolator
import android.widget.Button
import android.widget.ImageButton
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
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
    private lateinit var btnProfile: Button

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

        btnProfile = root.findViewById(R.id.help_button)

        val (gray, red, green) = getButtonColors()

        btnDislike.setOnClickListener {
            btnDislike.backgroundTintList = ColorStateList.valueOf(red)
            btnDislike.imageTintList = ColorStateList.valueOf(gray)
            handler.postDelayed({ update(btnDislike) }, DELAY_TIME)
        }

        btnLike.setOnClickListener {
            btnLike.backgroundTintList = ColorStateList.valueOf(green)
            btnLike.imageTintList = ColorStateList.valueOf(gray)
            handler.postDelayed({ update(btnLike) }, DELAY_TIME)
        }

        btnProfile.setOnClickListener{
            val navController = findNavController()
            navController.navigate(R.id.action_fragment_match_to_fragment_account)
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

    private fun getButtonColors(): Triple<Int, Int, Int> {
        val gray = ContextCompat.getColor(context!!, R.color.light_gray)
        val red = ContextCompat.getColor(context!!, R.color.red)
        val green = ContextCompat.getColor(context!!, R.color.green)
        return Triple(gray, red, green)
    }

    override fun onCardDragging(direction: Direction, ratio: Float) {
        Log.d("CardStackView", "onCardDragging: d = ${direction.name}, r = $ratio")

        val (gray, red, green) = getButtonColors()

        fun setButtonTint(button: ImageButton, color: Int, ratio: Float) {
            button.backgroundTintList = if (ratio < 0.6) {
                val hsv = FloatArray(3)
                Color.colorToHSV(color, hsv)
                hsv[1] = ratio / 0.6f * 0.75f
                ColorStateList.valueOf(Color.HSVToColor(hsv))
            } else {
                ColorStateList.valueOf(color)
            }
        }
        fun setForegroundTint(button: ImageButton, color: Int, ratio: Float) {
            button.imageTintList = if (ratio < 0.6) {
                val hsv = FloatArray(3)
                Color.colorToHSV(color, hsv)
                hsv[1] = 1-(ratio / 0.4f)
                ColorStateList.valueOf(Color.HSVToColor(hsv))
            } else {
                ColorStateList.valueOf(gray)
            }
        }

        if (direction == Direction.Left) {
            btnLike.backgroundTintList = ColorStateList.valueOf(gray)
            btnLike.imageTintList = ColorStateList.valueOf(green)
            setButtonTint(btnDislike, red, ratio)
            setForegroundTint(btnDislike, red, ratio)
        } else if (direction == Direction.Right) {
            btnDislike.backgroundTintList = ColorStateList.valueOf(gray)
            btnDislike.imageTintList = ColorStateList.valueOf(red)
            setButtonTint(btnLike, green, ratio)
            setForegroundTint(btnLike, green, ratio)
        }
    }

    override fun onCardSwiped(direction: Direction) {
        Log.d("CardStackView", "onCardSwiped: p = ${manager.topPosition}, d = $direction")
        if (manager.topPosition == adapter.itemCount - 1) {
            paginate()
        }
        val (gray, red, green) = getButtonColors()
        btnDislike.backgroundTintList = ColorStateList.valueOf(gray)
        btnLike.backgroundTintList = ColorStateList.valueOf(gray)
        btnDislike.imageTintList = ColorStateList.valueOf(red)
        btnLike.imageTintList = ColorStateList.valueOf(green)
    }

    override fun onCardRewound() {
        Log.d("CardStackView", "onCardRewound: ${manager.topPosition}")
    }

    override fun onCardCanceled() {
        Log.d("CardStackView", "onCardCanceled: ${manager.topPosition}")
        val (gray, red, green) = getButtonColors()
        btnDislike.backgroundTintList = ColorStateList.valueOf(gray)
        btnLike.backgroundTintList = ColorStateList.valueOf(gray)
        btnDislike.imageTintList = ColorStateList.valueOf(red)
        btnLike.imageTintList = ColorStateList.valueOf(green)
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
        manager.setSwipeThreshold(0.3f)
        manager.setMaxDegree(40f)
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
        companies.add(Company(name = "Fontys Hogeschool", openPosition = "Teacher ICT Smart mobile", city = "Eindhoven", urls = listOf(
            "https://yt3.googleusercontent.com/ytc/AL5GRJUei-YFtil1rTe6CsZ0v_ejWk2No8LKKQrHktewhg=s176-c-k-c0x00ffffff-no-rj",
            "https://yt3.googleusercontent.com/ytc/AL5GRJWDqmxYFhm2QFG1bU_nw9M4HiFstBtOxvFp2Ikv_A=s900-c-k-c0x00ffffff-no-rj",
            "https://www.fontysictinnovationlab.nl/site/assets/files/1049/strijptq-entry.png",
            "https://www.studiomoj.nl/wp-content/uploads/2018/09/lr-FH-ICT-12.jpg")))
        companies.add(Company(name = "Hard Rock Cafe", openPosition = "Bartender", city = "Amsterdam", urls = listOf(
            "https://d2q79iu7y748jz.cloudfront.net/s/_squarelogo/256x256/b98c482e48e4079242bfa8e3439699ad"
        )))
        companies.add(Company(name = "WerkCentrale Nederland", openPosition = "Manager Customer Service", city = "Rozenburg", urls = listOf(
            ""
        )))
        return companies
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
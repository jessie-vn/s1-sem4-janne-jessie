package nl.jobr.ui.home

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions
import nl.jobr.R
import java.util.*


class CardStackAdapter(
    private var companies: List<Company> = emptyList()
) : RecyclerView.Adapter<CardStackAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        return ViewHolder(inflater.inflate(R.layout.card_item, parent, false))
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val company = companies[position]
        holder.name.text = company.name
        holder.position.text = company.openPosition
        holder.city.text = company.city
        val random = Random()
        holder.percentage.text = (random.nextInt(91) + 10).toString() + "%"

        // Keep track of the current image index for the company
        var currentImageIndex = 0

        Glide.with(holder.image)
            .load(company.urls[currentImageIndex]) // Load the first image
            .error(R.drawable.no_image)
            .into(holder.image)

        holder.fade.setOnClickListener { v ->
            holder.moreInfoLayout.visibility = View.VISIBLE
        }

        holder.image.setOnClickListener { v ->
            // Increment the current image index
            currentImageIndex = (currentImageIndex + 1) % company.urls.size

            Glide.with(holder.image)
                .load(company.urls[currentImageIndex])
                .error(R.drawable.no_image)
                .transition(DrawableTransitionOptions.withCrossFade(300))
                .into(holder.image)

            val preloadIndex = (currentImageIndex + 1) % company.urls.size
            Glide.with(v)
                .load(company.urls[preloadIndex])
                .preload()
        }
    }

    override fun getItemCount(): Int {
        return companies.size
    }

    fun setCompanies(companies: List<Company>) {
        this.companies = companies
    }

    fun getCompanies(): List<Company> {
        return companies
    }

    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val name: TextView = view.findViewById(R.id.item_name)
        var position: TextView = view.findViewById(R.id.item_position)
        var city: TextView = view.findViewById(R.id.item_city)
        var image: ImageView = view.findViewById(R.id.item_image)

        var fade: ImageView = view.findViewById(R.id.fade)
        var percentage: TextView = view.findViewById(R.id.percentage_text)
        var moreInfoLayout: LinearLayout = view.findViewById(R.id.more_info_layout)
    }

}
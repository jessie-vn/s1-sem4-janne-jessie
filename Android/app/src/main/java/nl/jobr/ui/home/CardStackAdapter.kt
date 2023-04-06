package nl.jobr.ui.home

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import nl.jobr.R


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
        Glide.with(holder.image)
            .load(company.url)
            .error(R.drawable.no_image)
            .into(holder.image)

        //TODO: Add functionalities
        holder.fade.setOnClickListener { v ->
            Toast.makeText(v.context, "fade", Toast.LENGTH_SHORT).show()
        }
        holder.image.setOnClickListener { v ->
            Toast.makeText(v.context, "picture", Toast.LENGTH_SHORT).show()
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
    }

}
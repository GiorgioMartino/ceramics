---
layout: default
title: Home
---

[//]: # (<section class="hero">)

[//]: # (  <h1>{{ site.title }}</h1>)

[//]: # (  <p class="subtitle">{{ site.description }}</p>)

[//]: # (  <p><a class="cta" href="{{ '/pieces/' | relative_url }}">Filter by availability & category</a></p>)

[//]: # (</section>)

{% assign featured = site.pieces | where: "featured", true | sort: "year" | reverse %}
{% assign rest = site.pieces | where_exp: "p", "p.featured != true" | sort: "year" | reverse %}
{% assign all_pieces = featured | concat: rest %}

{% if all_pieces and all_pieces.size > 0 %}
  <section class="featured home-portfolio">
    <h1>Portfolio</h1>
    <div class="grid home-portfolio-grid">
      {% for piece in all_pieces %}
        {% assign status = piece.status | downcase %}
        <article class="card">
          <a class="card-link" href="{{ piece.url | relative_url }}">
            <div class="thumb">
              {% if piece.images and piece.images.size > 0 %}
                <img src="{{ piece.images[0] | relative_url }}" alt="{{ piece.title }}" loading="lazy" />
              {% else %}
                <div class="thumb-placeholder">No image yet</div>
              {% endif %}
              {% if status == "available" %}
                <span class="badge badge-available">Available</span>
              {% endif %}
            </div>
          </a>
        </article>
      {% endfor %}
    </div>
  </section>
{% endif %}
---
layout: default
title: Home
---

<section class="hero">
  <h1>{{ site.title }}</h1>
  <p class="subtitle">{{ site.description }}</p>
  <p><a class="cta" href="{{ '/pieces/' | relative_url }}">View the gallery</a></p>
</section>

{% assign featured = site.pieces | where: "featured", true | sort: "year" | reverse %}
{% if featured and featured.size > 0 %}
  <section class="featured">
    <h2>Featured</h2>
    <div class="grid">
      {% for piece in featured limit: 6 %}
        <article class="card">
          <a class="card-link" href="{{ piece.url | relative_url }}">
            <div class="thumb">
              {% if piece.images and piece.images.size > 0 %}
                <img src="{{ piece.images[0] | relative_url }}" alt="{{ piece.title }}" loading="lazy" />
              {% endif %}
            </div>
            <div class="meta">
              <h3 class="title">{{ piece.title }}</h3>
              <div class="sub">{% if piece.year %}{{ piece.year }}{% endif %}</div>
            </div>
          </a>
        </article>
      {% endfor %}
    </div>
  </section>
{% endif %}
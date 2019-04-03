---
---

{% assign count = 0 %}
{% assign align = "left" %}
{% for gallery in site.data.galleries.overview.albums %}
{% if count == 0 %}<div class="row">{% endif %}
  <div class="half-width gallery-preview {{ align }}">
    <h1>{{ gallery.title }}</h1>
    <a href="{{ site.url }}{{ site.baseurl }}/albums/{{ gallery.id }}.html">
      <img alt="{{ gallery.title }}" src="{{ gallery.image }}" style="width: {{ site.data.galleries.overview.image_width }}" />
    </a>
  </div>
{% if count == 1 %}</div>{% endif %}
{% assign count = count | plus: 1 %}
{% assign align = "right" %}
{% if count >= 2 %}
{% assign align = "left" %}
{% assign count = 0 %}
{% endif %}
{% endfor %}

{% if count != 1 %}
</div>
{% endif %}

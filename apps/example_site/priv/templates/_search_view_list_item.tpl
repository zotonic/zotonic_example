{% if id.is_visible %}
<div class="list-item{% if is_highlight or id.is_featured %} featured{% endif %} do_clickable">
    <p class="title">
        <span>{{ id.title|default:_"Untitled" }}</span>
        <em>
            &ndash; <small class="text-muted"> {{ id.category_id.title }} </small>
        </em>
        <a href="{{ id.page_url }}">
            {_ Read more _}&nbsp;&raquo;
        </a>
    </p>
</div>
{% endif %}

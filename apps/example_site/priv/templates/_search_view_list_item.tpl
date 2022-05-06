{% if id.is_visible %}
<div class="list-item{% if is_highlight or id.is_featured %} featured{% endif %} do_clickable">
    <p class="title">
        <span>{{ id.title|default:_"Untitled" }}</span>
        {% if is_show_cat %}
            <em>
                &ndash; <small class="text-muted"> {{ id.category_id.title }} </small>
            </em>
        {% endif %}
    </p>
</div>
{% endif %}

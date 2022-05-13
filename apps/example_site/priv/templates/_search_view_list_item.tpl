{% if id.is_visible %}
<div class="list-item{% if is_highlight or id.is_featured %} featured{% endif %} do_clickable">
    <p class="title">
        <span>{{ id.title|default:_"Untitled" }}</span>
        <em>
            &ndash; <small class="text-muted"> {{ id.category_id.title }} </small>
        </em>
        <a href="{{ id.page_url }}" class="btn btn-default btn-xs">
            {_ view _}
        </a>
        {% if m.acl.is_admin %}
            <a href="{% url admin_edit_rsc id=id %}" class="btn btn-default btn-xs">
                {_ edit _}
            </a>
        {% endif %}
    </p>
</div>
{% endif %}

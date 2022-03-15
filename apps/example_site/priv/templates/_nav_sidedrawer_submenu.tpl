<ul class="nav nav-stacked">
{% for node in menu %}
    {% if node.id.is_visible %}
        <li class="{% if node.id == id %}selected {% endif %} {% if node.id|member:trail %} nav__show{% endif %}">
            <a href="{{ node.id.page_url }}">{{ node.id.short_title|default:node.id.title }}</a>

            {# Shows all menu items on the path to the current menu item, and the
             # submenu below the current menu item.
             #}
            {% if node.tree and node.id|member:trail %}
                {% include "_nav_sidedrawer_submenu.tpl" menu=node.tree %}
            {% endif %}
        </li>
    {% endif %}
{% endfor %}
</ul>

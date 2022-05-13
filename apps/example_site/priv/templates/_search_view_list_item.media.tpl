{#
    This is a special variation on the '_search_view_list_item.tpl' template.
    It is used for pages with category 'website'.
    And is included as:

        {% catinclude "_search_view_list_item.tpl" id %}

    Where 'id' contains the id of a page in category 'website' or a sub-category
#}
{% if id.is_visible %}
<div class="list-item list-item-media {% if is_highlight or id.is_featured %} featured{% endif %} do_clickable">
    {% image id mediaclass="small-crop" crop=crop link=link alt=id.title %}
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

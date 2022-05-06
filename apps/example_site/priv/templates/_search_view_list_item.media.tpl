{#
    This is a special variation on the '_search_view_list_item.tpl' template.
    It is used for pages with category 'website'.
    And is included as:

        {% catinclude "_search_view_list_item.tpl" id %}

    Where 'id' contains the id of a page in category 'website' or a sub-category
#}
{% if id.is_visible %}
<div class="list-item list-item-media {% if is_highlight or id.is_featured %} featured{% endif %} do_clickable">
    <!-- TODO: too big images -->
    <figure>
        {% image id mediaclass="list-item" crop=crop link=link alt=id.title %}
    </figure>
    <p class="title">
        <span>{{ id.title|default:_"Untitled" }}</span>
        <em>
            &ndash; <small class="text-muted"> {{ id.category_id.title }} </small>
        </em>
    </p>
</div>
{% endif %}

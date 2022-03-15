{#
    This is a special variation on the '_list_item.tpl' template.
    It is used for pages with category 'website'.
    And is included as:

        {% catinclude "_list_item.tpl" id %}

    Where 'id' contains the id of a page in category 'website' or a sub-category
#}
{% if id.is_visible %}
<div class="list-item list-item-media {% if is_highlight or id.is_featured %} featured{% endif %} do_clickable">
    <p class="title">
        <a href="{{ id.page_url }}">
            {{ id.title|default:_"Untitled" }}
        </a>
    </p>
    <figure>
        {% image id mediaclass="list-item" crop=crop link=link alt=id.title %}
        <figcaption class="maincolumn-figure">{{ id|summary }}</figcaption>
    </figure>
</div>
{% endif %}

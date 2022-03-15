{#
    Page for media items.
    Media can be images, videos and documents.

    In this case we display a big preview image and a download.
    If there is a website then we display a link to the website.
#}
{% extends "base.tpl" %}

{% block content %}
    <article>
        <h1>{{ id.title }}</h1>

        {% include "_body_media.tpl" id=id mediaclass="body-media-large" align="left" caption='-' link={media_inline id=id}|url %}

        <p class="summary">
            {{ id.summary }}
        </p>

        <div class="body">
            {{ id.body|show_media }}
        </div>

        {% if id.website %}
            <p>
                <a href="{{ id.website }}" target="_blank"><span class="fa fa-external-link"></span> {{ id.website }}</a>
            </p>
        {% endif %}

        {% if id.medium as medium %}
            {% if medium.size > 0 %}
                <p class="text-muted">
                    {# Medium properties are not sanitized, so be careful to escape them #}
                    {{ medium.mime|escape }} {{ medium.size|filesizeformat }}
                </p>
                <p>
                    <a href="{% url media_inline id=id %}" target="_blank" class="btn btn-primary">{_ Download in new window _}</a>
                </p>
            {% endif %}
        {% endif %}
    </article>
{% endblock %}

{% block content_after %}
<div class="page-relations">

    {% if id.s.depiction as deps %}
        <div class="connections">
            <h3>{_ Depiction of _}</h3>
            <div class="list-items">
                {% for id in deps %}
                    {% catinclude "_list_item.tpl" id %}
                {% endfor %}
            </div>
        </div>
    {% endif %}

    <div class="connections">
        <h3>{_ Latest in _} {{ id.category_id.title }}</h3>
        <div class="list-items">
            {% for id in m.search[{latest cat=id.category_id pagelen=20}] %}
                {% catinclude "_list_item.tpl" id %}
            {% endfor %}
        </div>
    </div>

</div>
{% endblock %}
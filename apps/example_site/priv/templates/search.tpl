{% extends "base.tpl" %}

{% block title %}
    {_ Search _}: {{ q.qs|escape }}
{% endblock %}

{% block body_class %}search{% endblock %}

{% block content %}
    <article>
        <h1>{_ Search _}</h1>

        <form class="search-form" action="{% url search %}" method="GET">
            <p class="label-floating">
                <input autocomplete="off" placeholder="{_ Text to search _}" name="qs" class="form-control" name="qs" value="{{ q.qs|escape }}">
            </p>
        </form>
    </article>

    {% with q.page|default:1 as qpage %}
        {% if q.qs|trim|length > 0 %}
            <div class="search-results">
                {% with m.search.paged.query::%{
                            text: q.qs,
                            cat: [ "text", "media" ],
                            page: q.page,
                            pagelen: 20
                        }
                        as result %}

                    <div class="connections paged">
                        <h2>{{ result.total }} {_ Pages _}</h2>

                        <div class="list-items">
                            {% for id in result %}
                                {% catinclude "_list_item.tpl" id is_show_cat %}
                            {% endfor %}
                        </div>
                    </div>

                    {% pager result=result qargs %}
                {% endwith %}
            </div>
        {% endif %}
    {% endwith %}
{% endblock %}

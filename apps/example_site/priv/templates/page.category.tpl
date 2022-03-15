{% extends "page.tpl" %}

{% block content_after %}

<div class="page-relations">

    {% if id.o.haspart|is_visible as haspart %}
        <dl class="connections">
            {% for id in haspart %}
                <dt><a href="{{ id.page_url }}">{{ id.title }}</a></dt>
                <dd class="do_clickable">
                    {{ id|summary:160 }}
                    <a href="{{ id.page_url }}"></a>
                </dd>
            {% endfor %}
        </dl>
    {% endif %}

    {% for s in id.s.haspart|is_visible %}
        {% with s.o.haspart|is_visible as siblings %}
        {% for p in s.o.haspart %}
            {% if p == id %}
                <p class="page-haspart">
                    {% if siblings[forloop.counter - 1] as prev %}
                        <a class="haspart__prev" href="{{ prev.page_url }}">{{ prev.title }}</a>
                    {% else %}
                        <span></span>
                    {% endif %}
                    <a class="haspart__link" href="{{ s.page_url }}">{{ s.title }}</a>
                    {% if siblings[forloop.counter + 1] as next %}
                        <a class="haspart__next" href="{{ next.page_url }}">{{ next.title }}</a>
                    {% endif %}
                </p>
            {% endif %}
        {% endfor %}
        {% endwith %}
    {% endfor %}

    {% if id.o.relation|is_visible as relo %}
        <div class="connections">
            <h3>{_ See more _}</h3>

            <div class="list-items">
                {% for id in relo %}
                    {% catinclude "_list_item.tpl" id %}
                {% endfor %}
            </div>
        </div>
    {% endif %}

    {% with m.search.query::%{
            cat=id,
            sort="-created",
            pagelen=20,
            page=q.page
        } as result
    %}
        <div class="connections paged" id="content-pager">
            <h3>
                {_ All _} <span>{{ id.title }}</span>
            </h3>
            <div class="list-items">
                {% for id in result %}
                    {% catinclude "_list_item.tpl" id %}
                {% endfor %}
            </div>

            {% pager result=result id=id qargs hide_single_page %}
        </div>
    {% endwith %}
</div>

{% endblock %}

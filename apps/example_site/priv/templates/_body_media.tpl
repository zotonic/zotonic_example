{% with size|default:'large' as size %}
{% with mediaclass|default:("body-media-" ++ size) as mediaclass %}
{% if id.medium as medium %}
    {% if size == 'small' %}
        <label for="{{ #img }}" class="margin-toggle">⊕</label>
        <input type="checkbox" id="{{ #img }}" class="margin-toggle">
        <span class="marginnote">
            {% if id.is_a.video %}
                <div class="oembed-wrapper">
                    {% media medium mediaclass=mediaclass %}
                </div>
            {% else %}
                {% media medium mediaclass=mediaclass crop=crop link=link alt=id.title %}
                {% if caption /= '-' %}
                    {% if caption|default:(id|summary) as caption %}
                        <br>{{ caption }}
                    {% endif %}
                {% endif %}
            {% endif %}
        </span>
    {% elseif size == 'medium' %}
        <figure>
            {% if id.is_a.video %}
                <div class="oembed-wrapper">
                    {% media medium mediaclass=mediaclass %}
                </div>
            {% else %}
                {% media medium mediaclass=mediaclass crop=crop link=link alt=id.title %}
                {% if caption /= '-' %}
                    {% if caption|default:(id|summary) as caption %}
                        <figcaption class="maincolumn-figure">{{ caption }}</figcaption>
                    {% endif %}
                {% endif %}
            {% endif %}
        </figure>
    {% else %}
        <figure class="fullwidth">
            {% if id.is_a.video %}
                <div class="oembed-wrapper">
                    {% media medium mediaclass=mediaclass %}
                </div>
            {% else %}
                {% media medium mediaclass=mediaclass crop=crop link=link alt=id.title %}
                {% if caption /= '-' %}
                    {% if caption|default:(id|summary) as caption %}
                        <figcaption>{{ caption }}</figcaption>
                    {% endif %}
                {% endif %}
            {% endif %}
        </figure>
    {% endif %}
{% endif %}
{% endwith %}
{% endwith %}

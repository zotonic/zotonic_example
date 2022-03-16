{#
    This is the template for the home page.

    It is selected by the dispatch rule (see priv/dispatch/dispatch):

    {home, [], controller_page, [ {template, "home.tpl"}, {id, page_home} ]}

    This selects the resource with unique name "page_home", and displays it
    using the template "home.tpl".

    Normally the controller_page would use "page.tpl", but as the home page is
    special we use "home.tpl", which is also a convention normally used for
    Zotonic sites.

    Note that the resource page_home has its "page_path" property set to "/".
    This matches with the the empty ([]) path of the 'home' dispatch rule.
#}
{% extends "base.tpl" %}

{% block title %}{{ m.site.title }}{% endblock %}

{% block content %}

    <article>
        <p class="home__summary">
            {# Show the summary of the resource. Here 'id.summary is a shortcut #}
            {# for m.rsc[id].summary. The m.rsc[id] notation should be used if  #}
            {# 'id' came from an untrusted source. In this case 'id' comes from #}
            {# controller_page, which ensures that the passed id is sanitized.  #}
            {{ id.summary }}
        </p>

        {# Show blocks with all pages connected from the home page using the #}
        {# 'featured' predicate. These are shown as colored blocks.          #}
        <div class="home__featured">

            {# The "id.o.haspart" requests a list of all objects ('o') with #}
            {# the 'haspart' predicate.                                     #}
            {% for id in id.o.haspart %}
                {# The 'do_clickable' is a "widget". This is implementend by #}
                {# z.clickable.js. Using these classes behavior can be added #}
                {# in a declarative way. 'do_clickable' catches clicks and   #}
                {# the follows the first anchor href in the child elements.  #}
                <div class="home__featured__item do_clickable">
                    {# The image depiction of the resource. This is either      #}
                    {# the resource itself (for images etc) or the image        #}
                    {# attached to the resource using the 'depiction' predicate #}
                    {# The 'mediaclass' defines how the image is resized, these #}
                    {# are defined in priv/templates/mediaclass.config          #}
                    {% image id mediaclass="home-featured" %}

                    {# The 'page_url' property generated the URL for the resource, it #}
                    {# uses the 'page' dispatch rule or a dispacth rule with the name #}
                    {# of the category of the resource. See priv/dispatch/dispatch    #}
                    <h2><a href="{{ id.page_url }}">{{ id.title }}</a></h2>
                    <p>
                        {# The summary filter takes the summary property or the body  #}
                        {# and derives a summary of the given length. Here 120 chars. #}
                        {{ id|summary:120 }}
                    </p>
                </div>
            {% endfor %}

            {# Padding divs to pad out the flex box of home__featured on wider screens #}
            <div></div>
            <div></div>
        </div>

        {# The home page body, for a short text with images expanded. #}
        {# In this text we explain all the pro's of using Zotonic     #}
        <div class="home__body">
            {{ id.body|show_media }}
        </div>

        {# Show a list with articles and pages we want to highlight on the home page #}
        <div class="home__list">

            {# Note the {_ .. _} tags. They surround translatable texts. A .pot file   #}
            {# with all texts is created in priv/translations/template/ via the button #}
            {# on the /admin/translation page.                                         #}
            <h2>{_ Recent updates. _}</h2>

            {# Search for the latest 20 articles, video, and documents.                #}
            {# The 'cat' is an argumment for the 'query' search, which is implemeted   #}
            {# by module `mod_search`.                                                 #}
            {# The 'is_featured' is set for featured items, the "-is_featured" will    #}
            {# sort 'true' values first.                                               #}
            {% for id in m.search.query::%{
                    cat: [ "article", "video", "document" ],
                    is_published: true,
                    sort: [ "-is_featured", "-created" ],
                    pagelen: 20,
                    page: 1
                }
            %}
                {% if id.is_a.video %}
                    {# Videos are shown inline, so that they can be played on the home page. #}
                    <div class="home__list__item{% if id.is_featured %} featured{% endif %}">
                        <figure class="fullwidth">
                            <div class="oembed-wrapper">
                                {# The 'media' tag is much like 'image', except for multi-media  #}
                                {# the media tag will display a video or audio player, where the #}
                                {# image tag will display a static img tag.                      #}
                                {% media id mediaclass=mediaclass %}
                            </div>
                        </figure>
                    </div>
                {% else %}
                    <div class="home__list__item{% if id.is_featured %} featured{% endif %} do_clickable">
                        {# The "_body_media.tpl" is also used to show media in the body texts. #}
                        {# Here we re-use it and request a 'large' version of the image.       #}
                        {% include "_body_media.tpl" id=id.o.depiction size='large' %}
                        <h2><a href="{{ id.page_url }}">{{ id.title }}</a></h2>
                        <p>
                            {{ id|summary:240 }}
                        </p>
                    </div>
                {% endif %}
            {% endfor %}
        </div>

    </article>

{% endblock %}

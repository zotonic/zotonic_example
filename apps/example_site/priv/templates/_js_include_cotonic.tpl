{% lib
    "js/modules/jstz.min.js"
    "cotonic/cotonic-bundle.js"
%}

{% worker name="auth" src="js/zotonic.auth.worker.js" args=%{  auth: m.authentication.status  } %}

{% block _js_include_extra %}{% endblock %}


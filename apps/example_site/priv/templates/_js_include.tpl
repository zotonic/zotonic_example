
{% lib
    "js/apps/jquery-latest.min.js"
    "js/apps/jquery-ui-latest.min.js"
    "js/modules/jquery.ui.touch-punch.min.js"
%}

{% lib
    "js/modules/jstz.min.js"
    "cotonic/cotonic.js"
    "js/apps/zotonic-wired.js"
    "js/apps/z.widgetmanager.js"
    "js/modules/z.notice.js"
    "js/modules/z.dialog.js"
    "js/modules/z.clickable.js"
    "js/modules/z.survey_test_feedback.js"
    "js/modules/livevalidation-1.3.js"
    "js/modules/jquery.loadmask.js"
    "bootstrap/js/bootstrap.min.js"
    "js/zotonic-search-view.js"

    minify
%}

{% worker name="auth" src="js/zotonic.auth.worker.js" args=%{  auth: m.authentication.status  } %}

{% block _js_include_extra %}{% endblock %}

<script type="text/javascript" nonce="{{ m.req.csp_nonce }}">
  let lastScrollTop = 0;
  let isScrolledDown = false;

  let checkScrollPosition = function() {
    var scrollTop = $(document).scrollTop();
    if (scrollTop > lastScrollTop) {
      if (!isScrolledDown && scrollTop > 50) {
        $('body').addClass('scrolled-down');
        isScrolledDown = true;
      }
    } else if (isScrolledDown) {
      $('body').removeClass('scrolled-down');
      isScrolledDown = false;
    }
    lastScrollTop = scrollTop;
  }
  window.onscroll = checkScrollPosition;
  window.onpageload = checkScrollPosition;
  window.onhashchange = function() {
    lastScrollTop = 0;
  };
</script>

<script type="text/javascript" nonce="{{ m.req.csp_nonce }}">
    $(function()
    {
        $.widgetManager();
    });
</script>

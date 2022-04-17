jQuery( document ).ready(function() {
  jQuery( '[name="qs"]' ).on('input', function() {
    var url = window.location.protocol + '//' + window.location.host;
    var surl = url + '/api/model/search/get/query?text=';
    var text = this.value;
    jQuery.ajax({
      type: 'GET',
  	  url: surl + text + '&options.properties[]=title,page_url'
  	}).done(function( data ) {
      jQuery( 'div' ).remove( '.search-view' );
      jQuery( 'input.form-control' ).after( '<div class="search-view"></div>' );

      if ( text.length != 0 ) {
        data['result']['result'].forEach(function(item) {
          if ( typeof item['title'] == 'string' ) {
            var result = item['title'];
          } else if ( typeof item['title'] == 'object' ) {
            var result = item['title']['tr']['en'];
          }

          if ( result.length != 0 ) {
            jQuery( ".search-view" ).append( '<p>' + '<a href="' + url + item['page_url'] +  '">' + result + '</a></p>' );
          }

        });
      }
  	});
  });
});

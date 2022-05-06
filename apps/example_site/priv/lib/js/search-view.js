jQuery( document ).ready(function() {
    jQuery( '[name="qs"]' ).on('input', function() {
        var surl = window.location.protocol + '//' + window.location.host + '/search-view?qs=',
            form = jQuery( this ).closest( 'form' );
            that = this;

        jQuery.ajax({
            type: 'GET',
            url: surl + this.value
      	}).done(function( data ) {
            form.next().remove();
            form.after( data );

            jQuery( '.search-view-results li' ).on('click', function() {
                form.next().remove();
                that.value = jQuery( this ).find( 'span' ).text();
                form.submit();
            });
      	});
    });
});

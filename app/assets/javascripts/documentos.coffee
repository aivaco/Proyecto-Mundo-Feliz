$('.dropdown-toggle').dropdown();


$(document).on "page:change", ->
    $('#link-documentos').click -> 
        $('#documentos').toggle()
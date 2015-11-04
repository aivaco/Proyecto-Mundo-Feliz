var app = window.app = {};

app.Autocompletar = function() {
  this._input = $('#buscarClientes');
  this._initAutocomplete();
};

app.Autocompletar.prototype = {
_initAutocomplete: function() {
  this._input
    .autocomplete({
      source: '/modulo_cliente/modulo_cliente',
      appendTo: '#clientes-search',
      select: $.proxy(this._select, this)
    })
    .autocomplete('instance')._renderItem = $.proxy(this._render, this);
}, 
_select: function(e, ui) {
  this._input.val(ui.item.nombreEmp);
  return false;
},
_render: function(ul, item) {
  var markup = [
    '<span class="nombreEmp">' + item.nombreEmp + '</span>'
  ];
  return $('<li>')
    .append(markup.join(''))
    .appendTo(ul);
}
};
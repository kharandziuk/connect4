(function($) {
  return $(document).ready(function() {
    var i, j, _i, _results;
    _results = [];
    for (i = _i = 0; _i <= 5; i = ++_i) {
      $('#board table').append('<tr/>');
      _results.push((function() {
        var _j, _results1;
        _results1 = [];
        for (j = _j = 0; _j <= 6; j = ++_j) {
          console.log(i, j);
          $('#board tr').last().append('<td/>');
          _results1.push($('#board td').last().addClass('box').attr('data-row', i).attr('data-column', j));
        }
        return _results1;
      })());
    }
    return _results;
  });
})(jQuery);

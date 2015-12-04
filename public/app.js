$('#grocery-form').on("submit", function(event) {
  event.preventDefault();
  var newItem = $('#grocery-name').val();
  if (newItem) {
    makeAjaxRequestPost(newItem);
  } else {
    alert('Please enter an item!');
  }
});

$(document).on('click', '.delete_form', function(e) {
    event.preventDefault();

    var idClicked = e.target.id;
    var element = e.target
    makeAjaxRequestDelete(element, idClicked)
});

var makeAjaxRequestPost = function(postData) {
  var request = $.ajax({
    method: "POST",
    data: { name: postData },
    url: "/groceries.json"
  });

  request.success(function(data) {
    var form = '<form action="/groceries/jsdelete/' + data["id"] + '" method="post" class="delete_form"><input type="hidden" name="_method" value="DELETE"</input><input type="submit" value="Delete" id="' + data["id"] + '"></input></form>'
    $('<li class="item">' + data["name"] + " " + form + "</li>").appendTo("#grocery-list");
    $('#grocery-name').val('');
  });
};

var makeAjaxRequestDelete = function(element, id) {
  var request = $.ajax({
    method: "DELETE",
    url: "/groceries/jsdelete/" + id
  });

  request.done(function() {
    $(element).closest('.item').remove();
  });
};

$('#grocery-form').on("submit", function(event) {
  event.preventDefault();
  var newItem = $('#grocery-name').val();
  if (newItem) {
    makeAjaxRequest(newItem);
  } else {
    alert('Please enter an item!');
  }
});

var makeAjaxRequest = function(postData) {
  var request = $.ajax({
    method: "POST",
    data: { name: postData },
    url: "/groceries.json"
  });

  request.success(function() {
    $("#grocery-list").append("<li>" + postData + "</li>");
    $('#grocery-name').val('');
  });
};

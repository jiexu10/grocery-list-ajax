### Instructions

Make the grocery list app JavaScript-y!

### Getting Set Up

* Install the necessary dependencies: `bundle`
* Drop the `grocery_list_development` database with `dropdb grocery_list_development`.
* Create the database with `createdb grocery_list_development`.
* Create tables by running `psql grocery_list_development < schema.sql` at the command line.
* Start the server: `ruby app.rb`
* Modify the code in `public\app.js` to satisfy the following requirements.

### Requirements necessary to Meet Expectations

* If the form for a new grocery item is blank when submitting, the user gets an alert message.
* If the form is not empty, prevent the default action from happening, and post the new grocery item via the AJAX function provided.
* Upon successful posting of data, update the unordered list with the new grocery item. The list should be updated without having to reload the page.

Acceptance tests have been written for you that cover these requirements. Run `rspec` to run the test suite and implement code to make these tests pass.

### Tips

* To meet expectations, all the requirements specified above must be met. It is possible to make all the tests pass, but not satisfy the requirements above, so please double-check the requirements once you are done.
* The only file you will need to modify is `public/app.js` to fulfill these requirements.
* Use the provided HTML elements, `id` and `class` attributes to select DOM elements.
* Use the Chrome JavaScript console (`Command + Option + i`) to try out code, as well as to look for JavaScript error messages.
* **DO NOT** start the requirements necessary to Exceed Expectations until you have completed the requirements necessary to Meet Expectations.

### Requirements necessary to Exceed Expectations
As a Grocery List Creator, I want to delete an item from my list.

Without having to reload the page, your app must satisfy the following requirements:
* When a user clicks on a button html element next to the list item, it should trigger an event listener.
* Clicking on a list item must send an AJAX `DELETE` request to `/groceries`.
* Clicking on a list item must delete the respective item from the database. You may add code the the `server.rb` file, but do not modify the code we have provided you.
* Upon a successful AJAX request, the clicked item and its button should be removed from the page.
* Creating a new item via the form and clicking on the newly created item's button should delete the item.
* Write an acceptance test for this functionality. You do not have to use the `expect_no_page_reload` block in your test. However, you do need to let Capybara known that the test requires javascript by adding `js: true` to your `feature` block.

```ruby
feature "name of your feature", js: true do
end
```

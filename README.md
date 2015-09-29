# rails_events

Add Backbone style events without using the whole framework.
This will provide a bare bones front-end framework for developing Rails applications with Javascript or CoffeeScript.
This will increase the speed of all event based development and creation of dynamic content.

## Set up

Run the following command in terminal `rails generate rails_events`

## Usage

rails_events gives the ability to bind and trigger events in a backbone.js fashion.
The javascript files for the front-end use an events hash to keep track of how callbacks are fired.
The following demonstrates how to bind events to selectors.

CoffeeScript:
```CoffeeScript

class ProjectName.Views.modelsAction extends ProjectName.View
  events:
    'event selector' : 'callback'
    
  callback: (e) ->
    alert("Callback Fired!");
```

JavaScript:
```JavaScript

ProjectName.Views.modelsAction = ProjectName.View.extend({
    events: {
        'event selector': 'callback'
    },

    callback: function(e) {
        return alert("Callback Fired!");
    }
});
```

The proper naming conventions for the JavaScript/CoffeeScript files are the controller name camel cased with the controller action
i.e. `modelsAction.js`.

## Example

There is a `Company` model and controller with an `index` action.

`app/controllers/companies_controller.rb`
```Ruby

class CompaniesController < ApplicationController
  def index
  end
end
```

`app/views/companies/index.html`
```Html

<p class="company">
  Hello Company
</p>
```

`app/assets/javascripts/views/companiesIndex.js.coffee`

```CoffeeScript

class ProjectName.Views.CompaniesIndex extends ProjectName.View
  events:
    'click .company' : 'sayHello'

  sayHello: (e) ->
    alert("Hello!")
```

Alternatively, if you prefer to use Javascript, the backbone `extend` helper is included in `ProjectName.View` to make inheritance convenient:

`app/assets/javascripts/views/companiesIndex.js`

```JavaScript

ProjectName.Views.CompaniesIndex = ProjectName.View.extend({
    events: {
        'click .company': 'sayHello'
    },

    sayHello: function(e) {
        return alert("Hello!");
    }
});

```

When the text "Hello Company" is clicked, an alert with the text "Hello!" will pop up.

## Dependencies
The gems:

+ rails
+ underscore-rails
+ underscore-string-rails
+ jquery-rails

# rails_events

Add Backbone style events without using the whole framework

## Set up

Run the following command in terminal `rails generate rails_events`

## Usage

rails_events gives the ability to bind and trigger events in a backbone.js fashion.
The javascript files for the front-end use an events hash to keep track of how callbacks are fired.
The following CoffeeScript demonstrates how to bind events to objects.

```CoffeeScript

events:
  'event object' : 'callback'
```
  

## Example

There is a `Company` model and controller with an `index` action.

`app/controllers/companies_controller.rb`
```Ruby

class CompaniesController < ApplicationController
  def index
  end
end
```

`app/views/companies/index.html.erb`
```Html

<p class="company">
  Hello Company
</p>
```

To add rails_events, create the file `app/assets/javascripts/views/companiesIndex.js.coffee` with
the following code:

```CoffeeScript

class ProjectName.Views.CompaniesIndex extends ProjectName.View
  events:
    'click .company' : 'sayHello'

  sayHello: (e) ->
    alert("Hello!")
```

When the text "Hello Company" is clicked, an alert with the text "Hello!" will pop up.

## Dependencies

+ rails
+ underscore-rails
+ underscore-string-rails

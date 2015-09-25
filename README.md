# rails_events
Add Backbone style events without using the whole framework

## Set up

run the following command in terminal `rails generate rails_events`

This will create the following files:

`app/assets/javascripts/project_name.js.coffee`

and

`app/assets/javascripts/views/_project_name_view.js.coffee`

These will look very similar to the files that backbone.js creates.

## Usage

For example, there is a `Company` model and controller with an `index` view.
To add rails_events, create the file `app/assets/javascripts/views/companiesIndex.js.coffee` with
the following code:

```CoffeeScript

class ProjectName.Views.CompaniesIndex extends ProjectName.View
  events:
    'click .company' : 'sayHello'

  sayHello: (e) ->
    alert("Hello!")
```

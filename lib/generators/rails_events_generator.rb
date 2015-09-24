require 'rails/generators'
require 'rails/generators/base'

class RailsEventsGenerator < Rails::Generators::Base
  desc "This generator creates files at app/assets/javascripts/#{Rails.application.class.parent_name}.js.coffee and app/assets/javascripts/views/_#{Rails.application.class.parent_name}_view.js.coffee"

  def create_project_file
    project_name = Rails.application.class.parent_name
    create_file "app/assets/javascripts/#{project_name}.js.coffee", <<-FILE
window.#{project_name} =
  Views: {}
  Helpers: {}
  Ui: {}
  D3: {}
  Hierarchy: {}
  init: {}
  setView: ->
    #{project_name}.view.close() if #{project_name}.view? && #{project_name}.view.close
    view_name = $('body').data('view-render')
    return unless _.isFunction(#{project_name}.Views[view_name])
    #{project_name}.view = new #{project_name}.Views[view_name]
FILE
  end

  def create_project_view_file
    project_name = Rails.application.class.parent_name
    create_file "app/assets/javascripts/views/_#{project_name}_view.js.coffee", <<-FILE
class #{project_name}.View

  # To bind events you need to create an events object
  # KEY = event and selector : VALUE = method
  # events :
  #   {
  #     'eventName selector' : 'method',
  #     'eventName selector' : 'method',
  #   }

  constructor: (options) ->
    options or (options = {})
    @view_name = this.__proto__.constructor.name
    @render(options) if @render
    @delegateEvents()

  #regex to split keys
  delegateEventSplitter = /^(\\S+)\s*(.*)$/

  delegateEvents: =>
    # copied/modified from Backbone.View.delegateEvents
    # http://backbonejs.org/docs/backbone.html#section-138
    return this unless events or (events = _.result(this, 'events'))
    for key of events
      method = events[key]
      method = this[events[key]]  unless _.isFunction(method)
      continue  unless method
      match = key.match(delegateEventSplitter)
      eventName = match[1]
      selector = match[2]
      method = _.bind(method, this)
      eventName += \".\#{@view_name}\"
    $('body').on eventName, selector, method
    this

    close: =>
        $('body').off \".\#{@view_name}\"
    $(window).off \".\#{@view_name}\"
    $(document).off \".\#{@view_name}\"
    $('body').off '.#{project_name}Events'
    $(window).off '.#{project_name}Events'
    $(document).off '.#{project_name}Events'

    #{project_name}.Ui.Close()
    @postClose() if @postClose
FILE
  end

end

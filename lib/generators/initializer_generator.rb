require 'rails/generators'
require 'rails/generators/base'

class InitializerGenerator < Rails::Generators::Base
  desc "This generator creates an initializer file at config/initializers"

  def create_initializer_file
    create_file "config/initializers/initializer.rb", "# Add initialization content here"
  end


  # desc "This generator creates files at app/assets/javascripts/#{project_name}.js.coffee and app/assets/javascripts/views/_#{project_name}_view.js.coffee"
  #
  # def create_project_file
  #   create_file "app/assets/javascripts/#{project_name}.js.coffee", "
  #     window.#{project_name} =
  #       Views: {}
  #       Helpers: {}
  #       Ui: {}
  #       D3: {}
  #       Hierarchy: {}
  #       init: {}
  #       setView: ->
  #         #{project_name}.view.close() if #{project_name}.view? && #{project_name}.view.close
  #         view_name = $('body').data('view-render')
  #         return unless _.isFunction(#{project_name}.Views[view_name])
  #         #{project_name}.view = new #{project_name}.Views[view_name]
  #   "
  # end
  #
  # def create_project_view_file
  #   create_file "app/assets/javascripts/views/_#{project_name}_view.js.coffee", "
  #     class #{project_name}.View
  #
  #       # To bind events you need to create an events object
  #       # KEY = event and selector : VALUE = method
  #       # events :
  #       #   {
  #       #     'eventName selector' : 'method',
  #       #     'eventName selector' : 'method',
  #       #   }
  #
  #       constructor: (options) ->
  #         options or (options = {})
  #         @view_name = this.__proto__.constructor.name
  #         @render(options) if @render
  #         @delegateEvents()
  #
  #       #regex to split keys
  #       delegateEventSplitter = /^(\\S+)\s*(.*)$/
  #
  #       delegateEvents: =>
  #         # copied/modified from Backbone.View.delegateEvents
  #         # http://backbonejs.org/docs/backbone.html#section-138
  #         return this unless events or (events = _.result(this, 'events'))
  #         for key of events
  #           method = events[key]
  #           method = this[events[key]]  unless _.isFunction(method)
  #           continue  unless method
  #           match = key.match(delegateEventSplitter)
  #           eventName = match[1]
  #           selector = match[2]
  #           method = _.bind(method, this)
  #           eventName += \".\#{@view_name}\"
  #         $('body').on eventName, selector, method
  #         this
  #
  #         close: =>
  #             $('body').off \".\#{@view_name}\"
  #         $(window).off \".\#{@view_name}\"
  #         $(document).off \".\#{@view_name}\"
  #         $('body').off '.#{project_name}Events'
  #         $(window).off '.#{project_name}Events'
  #         $(document).off '.#{project_name}Events'
  #
  #         #{project_name}.Ui.Close()
  #         @postClose() if @postClose
  #   "
  # end

  private

  def project_name
    "Danny"
    # @project_name ||= Rails.application.class.parent_name
  end

end

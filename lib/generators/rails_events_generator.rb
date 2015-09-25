require 'rails/generators'
require 'rails/generators/base'

class RailsEventsGenerator < Rails::Generators::Base
  desc "This generator creates files at app/assets/javascripts/#{Rails.application.class.parent_name.underscore}.js.coffee and
app/assets/javascripts/views/_#{Rails.application.class.parent_name.underscore}_view.js.coffee"

  def create_project_file
    project_name_camel = Rails.application.class.parent_name.camelize
    project_name_snake = Rails.application.class.parent_name.underscore
    create_file "app/assets/javascripts/#{project_name_snake}.js", <<-FILE
window.#{project_name_camel} = {
	Views: {},
	Ui: {
		Close: function() {
			_.each(#{project_name_camel}.Ui, function(element) {
        if(element.close)
					element.close();
			})
		}
	},
	setView: function() {
		if(!!#{project_name_camel}.view && #{project_name_camel}.view.close)
			#{project_name_camel}.view.close();
    view_name = $('body').data('view-render');
    if(!_.isFunction(#{project_name_camel}.Views[view_name]))
			return;
    #{project_name_camel}.view = new #{project_name_camel}.Views[view_name]();
	}
}

// reinitialize app due to turbolinks
$(document).pageLoad(function() {
	#{project_name_camel}.setView()
})


// initial Document Load
$(document).ready(function() {
	#{project_name_camel}.setView()
})
FILE
  end

  def create_project_view_file
    project_name_camel = Rails.application.class.parent_name.camelize
    project_name_snake = Rails.application.class.parent_name.underscore
    create_file "app/assets/javascripts/views/_#{project_name_snake}_view.js.coffee", <<-FILE
class #{project_name_camel}.View

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
  delegateEventSplitter = /^(\\S+)\\s*(.*)$/

  delegateEvents: =>
    # copied/modified from Backbone.View.delegateEvents
    # http://backbonejs.org/docs/backbone.html#section-138
    return this unless events or (events = _.result(this, "events"))
    for key of events
      method = events[key]
      method = this[events[key]]  unless _.isFunction(method)
      continue  unless method
      match = key.match(delegateEventSplitter)
      eventName = match[1]
      selector = match[2]
      method = _.bind(method, this)
      eventName += ".\#{@view_name}"
      $('body').on eventName, selector, method
    this

  close: =>
    $('body').off ".\#{@view_name}"
    $(window).off ".\#{@view_name}"
    $(document).off ".\#{@view_name}"
    $('body').off '.#{project_name_camel}Events'
    $(window).off '.#{project_name_camel}Events'
    $(document).off '.#{project_name_camel}Events'

    #{project_name_camel}.Ui.Close()
    @postClose() if @postClose

FILE
  end

  def add_underscore_to_tree
    inject_into_file "app/assets/javascripts/application.js", after: "//= require jquery_ujs\n" do
      "//= require underscore\n"
    end
  end

  def add_project_to_tree
    project_name = Rails.application.class.parent_name.underscore
    inject_into_file "app/assets/javascripts/application.js", before: "\n//= require_tree ." do
      "\n//= require #{project_name}"
    end
  end

  def add_views_folder_to_tree
    project_name = Rails.application.class.parent_name.underscore
    inject_into_file "app/assets/javascripts/application.js", after: "//= require #{project_name}\n" do
      "//= require_tree ./views\n"
    end
  end

  def link_javascript_files_to_views
    inject_into_file "app/views/layouts/application.html.erb", after: "<body" do
      " data-view-render= <%= \"\#{@js_view.present? ? @js_view : controller_name.camelize+action_name.camelize}\" %>"
    end
  end
end

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
    viewName = $('body').data('view-render');
    if(!_.isFunction(#{project_name_camel}.Views[viewName]))
			return;
    #{project_name_camel}.view = new #{project_name_camel}.Views[viewName]();
	}
}

// reinitialize app due to turbolinks
$(document).on('pageload', function() {
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
    create_file "app/assets/javascripts/views/_#{project_name_snake}_view.js", <<-FILE
// To bind events you need to create an events object
// KEY = event and selector : VALUE = method
// events :
//   {
//     'eventName selector' : 'method',
//     'eventName selector' : 'method',
//   }

#{project_name_camel}.View = (function() {
    var delegateEventSplitter;

    function View(options) {
        this.close = _.bind(this.close, this);
        options || (options = {});
        this.viewName = this.__proto__.constructor.name;
        if (this.render)
            this.render(options);
        this.delegateEvents();
    }

    delegateEventSplitter = /^(\S+)\s*(.*)$/;

    View.prototype.delegateEvents = function(events) {
        // Copied/modified from Backbone.View.delegateEvents
        // http://backbonejs.org/docs/backbone.html#section-138
        var delegateEventSplitter = /^(\\S+)\\s*(.*)$/
        events || (events = _.result(this, 'events'));
        if (!events)
          return this;
        for (var key in events) {
          var method = events[key];
          if (!_.isFunction(method))
            method = this[method];
          if (!method)
            continue;
          var match = key.match(delegateEventSplitter);
          $('body').on(match[1], match[2], _.bind(method, this));
        }
        return this;
      };

    View.prototype.close = function() {
        $('body').off('.' + this.viewName);
        $(window).off('.' + this.viewName);
        $(document).off('.' + this.viewName);
        $('body').off('.#{project_name_camel}Events');
        $(window).off('.#{project_name_camel}Events');
        $(document).off('.#{project_name_camel}Events');
        if (this.postClose)
            return this.postClose();
    };

    View.extend = function(protoProps, staticProps) {
        // Copied from Backbone Helpers
        // http://backbonejs.org/docs/backbone.html#section-245
        var parent = this;
        var child;

        // The constructor function for the new subclass is either defined by you
        // (the "constructor" property in your `extend` definition), or defaulted
        // by us to simply call the parent constructor.
        if (protoProps && _.has(protoProps, 'constructor')) {
            child = protoProps.constructor;
        } else {
            child = function(){ return parent.apply(this, arguments); };
        }

        // Add static properties to the constructor function, if supplied.
        _.extend(child, parent, staticProps);

        // Set the prototype chain to inherit from `parent`, without calling
        // `parent`'s constructor function and add the prototype properties.
        child.prototype = _.create(parent.prototype, protoProps);
        child.prototype.constructor = child;

        // Set a convenience property in case the parent's prototype is needed
        // later.
        child.__super__ = parent.prototype;

        return child;
    };

    return View;

})();
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

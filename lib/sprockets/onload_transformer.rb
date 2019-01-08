require 'sprockets'

module Sprockets
  class OnloadTransformer
    def self.call(input)
      asset_name = input[:name]
      body = input[:data]
      util_function_name = "onloadTransformerUtil#{to_function_key(asset_name)}"
      wrapped_in_event = <<-JS
        var #{util_function_name} = (function() {
            #{body}
        }).bind(this)

        if (document.readyState === "loading") {
          document.addEventListener("DOMContentLoaded", #{util_function_name});
        } else {
          #{util_function_name}();
        };
      JS

      { data: wrapped_in_event }
    end

    def self.to_function_key(key)
      key.parameterize.underscore.camelize
    end
  end

  if respond_to?(:register_transformer)
    register_mime_type 'application/onload-javascript', extensions: ['.onload.js'], charset: :unicode
    register_transformer 'application/onload-javascript', 'application/javascript', OnloadTransformer
    register_preprocessor 'application/onload-javascript', DirectiveProcessor
  end

  if respond_to?(:register_engine)
    args = ['.onload.js',  OnloadTransformer]
    if Sprockets::VERSION.start_with?("3")
      args << { mime_type: 'application/javascript', silence_deprecation: true }
    end
    register_engine(*args)
  end
end

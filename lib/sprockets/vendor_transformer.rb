require 'sprockets'

module Sprockets
  class VendorTransformer
    def self.call(input)
      asset_name = input[:name]
      body = input[:data]
      util_function_name = "vendorTransformerUtilLoad#{to_function_key(asset_name)}"
      wrapped_in_event = <<-JS
        function #{util_function_name}() {
          #{body}
        };

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
    register_mime_type 'application/vendor-javascript', extensions: ['.vendor.js'], charset: :unicode
    register_transformer 'application/vendor-javascript', 'application/javascript', VendorTransformer
    register_preprocessor 'application/vendor-javascript', DirectiveProcessor
  end

  if respond_to?(:register_engine)
    args = ['.vendor.js',  VendorTransformer]
    if Sprockets::VERSION.start_with?("3")
      args << { mime_type: 'application/javascript', silence_deprecation: true }
    end
    register_engine(*args)
  end
end

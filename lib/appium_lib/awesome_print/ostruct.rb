# Enable OpenStruct support in awesome print
# Code from @marshallshen https://github.com/michaeldv/awesome_print/pull/145
#
# Copyright (c) 2010-2013 Michael Dvorkin
#
# Awesome Print is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------

if defined?(OpenStruct) &&
    Gem::Version.new(AwesomePrint.version) < Gem::Version.new("1.6.0") # Included in awesome_print 1.6.0
  module AwesomePrint
    module OpenStruct
      def self.included(base)
        base.send :alias_method, :cast_without_ostruct, :cast
        base.send :alias_method, :cast, :cast_with_ostruct
      end

      def cast_with_ostruct(object, type)
        cast = cast_without_ostruct(object, type)
        if (defined?(::OpenStruct)) && (object.is_a?(::OpenStruct))
          cast = :open_struct_instance
        end
        cast
      end

      def awesome_open_struct_instance(object)
        "#{object.class} #{awesome_hash(object.marshal_dump)}"
      end
    end # module OpenStruct
  end # module AwesomePrint

  AwesomePrint::Formatter.send(:include, AwesomePrint::OpenStruct)
end
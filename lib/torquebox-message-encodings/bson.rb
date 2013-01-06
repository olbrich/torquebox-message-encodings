begin
  require 'bson'
rescue LoadError => ex
  raise RuntimeError.new( "Unable to load the bson gem. Verify that is installed and in your Gemfile (if using Bundler)" )
end

module TorqueBox
  module Messaging
    class BSONMessage < Message
      ENCODING = :bson
      JMS_TYPE = :bytes

      def encode(message)
        unless message.nil?
          bsoned = ::BSON.serialize(message, false)
          @jms_message.write_bytes( bsoned.to_s.to_java_bytes )
        end
      end

      def decode
        if (length = @jms_message.get_body_length) > 0
          bytes = Java::byte[length].new
          @jms_message.read_bytes( bytes )
          @jms_message.reset
          ::BSON.deserialize( String.from_java_bytes( bytes ) )
        end
      end

    end

    Message.register_encoding( BSONMessage )
  end
end
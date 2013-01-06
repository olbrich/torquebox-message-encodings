begin
  require 'msgpack'
rescue LoadError => ex
  raise RuntimeError.new( "Unable to load the msgpack-jruby gem. Verify that is installed and in your Gemfile (if using Bundler)" )
end

module TorqueBox
  module Messaging
    class MsgpackMessage < Message
      ENCODING = :msgpack
      JMS_TYPE = :bytes

      def encode(message)
        unless message.nil?
          msgpacked = ::MessagePack.pack(message)
          @jms_message.write_bytes( msgpacked.to_s.to_java_bytes )
        end
      end

      def decode
        if (length = @jms_message.get_body_length) > 0
          bytes = Java::byte[length].new
          @jms_message.read_bytes( bytes )
          @jms_message.reset
          ::MessagePack.unpack( String.from_java_bytes( bytes ) )
        end
      end

    end

    Message.register_encoding( MsgpackMessage )
  end
end
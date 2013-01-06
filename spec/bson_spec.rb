require 'java'
require 'jboss-jms-api_1.1_spec-1.0.1.Final.jar'
require 'torquebox/messaging/message'
require 'lib/torquebox-message-encodings/bson'

include TorqueBox::Messaging
class MockBSONMessage
  include javax.jms::BytesMessage
  attr_accessor :bytes

  def get_string_property(_)
    "bson"
  end

  def write_bytes(packed_message)
    self.bytes = packed_message
  end

  def get_body_length
    self.bytes.size
  end

  def read_bytes(buffer)
    self.bytes.each_with_index do |byte, index|
      buffer.ubyte_set(index, byte)
    end
    get_body_length
  end

  def reset;  end
end

describe TorqueBox::Messaging::BSONMessage do

  before(:each) do
    @message = Message.new( MockBSONMessage.new )
  end

  it "should BSON encode a message" do
    String.from_java_bytes(@message.encode(key: 'bson')).should == "\x13\x00\x00\x00\x02key\x00\x05\x00\x00\x00bson\x00\x00"
  end

  it "should decode a BSON message" do
    @message.encode(key: 'bson')
    @message.decode.should == {"key"=>"bson"}
  end

end
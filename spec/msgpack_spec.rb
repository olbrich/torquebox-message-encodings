require 'java'
require 'jboss-jms-api_1.1_spec-1.0.1.Final.jar'
require 'torquebox/messaging/message'
require 'lib/torquebox-message-formats/msgpack'

include TorqueBox::Messaging
class MockMsgpackMessage
  include javax.jms::BytesMessage
  attr_accessor :bytes

  def get_string_property(_)
    "msgpack"
  end

  def write_bytes(packed_message)
    self.bytes = packed_message.clone
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

describe TorqueBox::Messaging::MsgpackMessage do

  before(:each) do
    @message = Message.new( MockMsgpackMessage.new )
  end

  it "should MSGPACK encode a message" do
    String.from_java_bytes(@message.encode(key: 'msgpack')).should == "\x81\xA3key\xA7msgpack"
  end

  it "should decode a MSGPACK message" do
    @message.encode(key: 'msgpack')
    @message.decode.should ==  {"key"=>"msgpack"}
  end

end
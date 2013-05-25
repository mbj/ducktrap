require 'spec_helper'

describe Ducktrap::Node::Static, '#inverse' do
  let(:object) { described_class.new(value, inverse_value) }

  let(:value)         { mock('Value')         }
  let(:inverse_value) { mock('Inverse Value') }

  subject { object.inverse }

  it { should eql(Ducktrap::Node::Static.new(inverse_value, value)) }
end
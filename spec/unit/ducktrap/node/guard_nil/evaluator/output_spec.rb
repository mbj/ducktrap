require 'spec_helper'

describe Ducktrap::Node::GuardNil::Evaluator, '#output' do
  let(:object) { described_class.new(context, input) }

  let(:context) { double('Context', :operand => operand) }

  subject { object.output }

  context 'when input is nil' do
    let(:operand) { double('Operand') }
    let(:input)   { nil             }

    it { should be(nil) }

    it_should_behave_like 'an idempotent method'
  end

  context 'when input is not nil' do
    let(:operand) { Ducktrap::Node::Noop.instance   }
    let(:input)   { double('Input', :frozen? => true) }

    it { should be(input) }

    it_should_behave_like 'an idempotent method'
  end
end

require 'spec_helper'

describe Ducktrap::Evaluator, '#successful?' do
  let(:object) { class_under_test.new(context, input) }

  let(:context) { double('Context') }
  let(:input)   { double('Input')   }

  subject { object.successful? }

  context 'when process is not successful' do

    let(:class_under_test) do
      Class.new(described_class) do
        def process
          error
        end
      end
    end

    it { should be(false) }
  end

  context 'when process is successful' do

    let(:class_under_test) do
      Class.new(described_class) do
        def process
          :result
        end
      end
    end

    it { should be(true) }
  end
end

require 'ducktrap'

class Address
  include Anima.new(:street, :city)
end

module Ducktrap
  def self.build(&block)
    Builder.build(&block)
  end

  class Builder
    include Morpher::NodeHelpers

    def self.build(&block)
      Morpher.compile(run(block))
    end

    def self.run(block)
      builder = new
      builder.instance_eval(&block)
      builder.result
    end

    def initialize
      @current = []
    end

    def add(node)
      @current << node
    end

    def result
      s(:block, *@current)
    end

    def load_strings(*keys)
      keys.each(&method(:load_string))
    end

    def load_string(key)
      load_key(key, String)
    end

    def load_fixnum(key)
      load_key(key, Fixnum)
    end

    def load_key(key, type)
      add(s(:key_symbolize, key, s(:guard, s(:primitive, type))))
    end

    def or(&block)
      body = visit(block)
      if body.length > 2
        raise
      end
      s(:xor, *body)
    end

    def visit(&block)
      Builder.run(block)
    end

    def load_model(model, &block)
      body = visit(&block).children
      @current << s(:block,
                    s(:guard, s(:primitive, Hash)),
                    s(:hash_transform, *body),
                    s(:load_attribute_hash, s(:param, model))
                  )
    end
  end
end

LOADER = Ducktrap.build do
  load_model(Address) do
    load_strings :street, :city
  end
end

describe 'spike' do
  it 'should work' do
    address = LOADER.call('street' => 'Some Street', 'city' => 'A city')
    expect(address).to eql(Address.new(street: 'Some Street', city: 'A city'))
  end
end


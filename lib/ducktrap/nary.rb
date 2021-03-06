module Ducktrap
  # Mixin for Nary ducktraps
  module Nary

    # Builder for nary ducktraps
    class Builder < Ducktrap::Builder

      # Add ducktrap argument
      #
      # @param [Ducktrap] ducktrap
      #
      # @return [self]
      #
      # @api private
      #
      def add(ducktrap)
        body << ducktrap
        self
      end

      # Hook called when method is missing
      #
      # @return [Object]
      #
      # @api private
      #
      def method_missing(name, *arguments, &block)
        builder = DSL.lookup(name) { super }
        add(builder.build(*arguments, &block))
      end

      # Return build instance
      #
      # @return [Object]
      #
      # @api private
      #
      def object
        @klass.new(body)
      end
      memoize :object

      # Return body
      #
      # @return [Enumerable<Ducktrap>]
      #
      # @api private
      #
      attr_reader :body

      # Initialize object
      #
      # @param [Class] klass
      #   the klass to build
      #
      # @param [Enumerable<Ducktrap>] body
      #   the body of nary ducktrap
      #
      # @api private
      #
      def initialize(klass, body = [])
        @body = body
        super(klass)
      end

    end # Builder

    module ClassMethods

      # Build ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def build(*arguments, &block)
        Builder.new(self, *arguments, &block).object
      end

    end # ClassMethods

    module InstanceMethods

    private

      # Return inverse body
      #
      # @return [Enumerable<Ducktrap>]
      #
      # @api private
      #
      def inverse_body
        body.map(&:inverse).reverse
      end

      # Dump instance
      #
      # @param [Formatter] output
      #
      # @return [undefined]
      #
      # @api private
      #
      def dump(output)
        output.name(self)
        output.body(body)
      end

    end # InstanceMethods

    CONCORD = Concord::Public.new(:body)

    # Hook called when module was included
    #
    # @param [Class,Module] scope
    #
    # @return [undefined]
    #
    # @api private
    #
    def self.included(scope)
      scope.extend(ClassMethods)
      scope.module_eval do
        include InstanceMethods
        include CONCORD
      end
    end
    private_class_method :included

    # Base class for nary evaluators
    class Evaluator < Ducktrap::Evaluator

    private

      # Return body
      #
      # @return [Enumerable<Ducktrap>]
      #
      # @api private
      #
      def body
        context.body
      end

    end # Evaluator

  end # Nary
end # Ducktrap

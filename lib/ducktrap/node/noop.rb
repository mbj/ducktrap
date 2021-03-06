module Ducktrap
  class Node
    # Noope node, returns input as output
    class Noop < self
      include Singleton

      register :noop

      # Run ducktrap
      #
      # @param [Object] input
      # 
      # @return [Evaluator]
      #
      # @api private
      #
      def call(input)
        Evaluator::Noop.new(self, input)
      end

      # Return inverse ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse; self; end
    end
  end
end

module Ducktrap

  # Error returned for invalid inputs
  class Error 
    include PrettyDump, Adamantium::Flat, Concord::Public.new(:context, :input)

  private

    # Dump state to output
    #
    # @param [Formatter] formatter
    #
    # @return [undefined]
    #
    # @api private
    #
    def dump(output)
      output.name(self)
      output.attribute(:input, input)
      output.nest(:context, context)
    end

    # Error caused by exception
    class Exception < self
      include Concord::Public.new(:context, :input, :exception)

    private

      # Dump state to output
      #
      # @param [Formatter] formatter
      #
      # @return [undefined]
      #
      # @api private
      #
      def dump(output)
        excpt = exception
        output.name(self)
        output.attribute(:input, input)
        output.attribute(:exception, excpt.class)
        output.attribute(:exception_message, excpt.message)
        output.nest(:context, context)
      end
    end

  end
end

require 'ducktrap'
require 'devtools'
Devtools.init_spec_helper

module StripHelper
  def strip(string)
    lines = string.lines
    first_line = lines.first
    match = /\A[ ]*/.match(first_line)
    length = match[0].length
    lines.map do |line|
      line[(length..-1)]
    end.join
  end
end

RSpec.configure do |config|
  config.extend(LetMockHelper)
  config.include(StripHelper)
end

require 'rainbow'

class RainbowLogger
  private

  attr_reader :level, :log_file

  public

  def initialize(log_file: nil, level: :info)
    @log_file = log_file
    @level = level
  end

  def call(message, color: :green)
    if log_file.nil?
      puts Rainbow(message).public_send(color)
    else
      File.open(log_file, 'a') do |file|
        file.puts Rainbow(message).send(rainbow_options[:color])
      end
    end
  end
end

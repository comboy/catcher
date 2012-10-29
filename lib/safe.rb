require 'logger'
require 'safe/prefixed_logger'
require 'safe/logger'

module Safe

  def self.logger
    @logger || setup_logger(STDOUT)
  end

  def self.logger=(logger)
    @logger = logger
  end

  def self.setup_logger(*args)
    @logger = ::Logger.new(*args)
    @logger.datetime_format = "%Y-%m-%d %H:%M:%S "
    @logger
  end
end


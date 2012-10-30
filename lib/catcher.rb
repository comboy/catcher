require 'logger'
require 'catcher/prefixed_logger'
require 'catcher/logger'

module Catcher

  def self.block(progname = nil)
    begin
      yield
    rescue Exception => e
      log_exception e, progname
    end
  end

  def self.thread(progname = nil)
    Thread.new do
      block progname do
        yield
      end
    end
  end

  def self.log_exception(e, progname)
    text = progname ? "Exception raised by '#{progname}'\n\t"  : ""
    if e.kind_of? Exception
      text << "[#{e.class}] #{e.message}\n\t#{e.backtrace.join("\n\t")}"
    else
      # This software is UFO ready
      text << "Some not very exceptional object raised o_O #{e.inspect} [#{e.class}]"
    end
    Catcher.logger.error text
  end

  def self.logger
    @logger || setup_logger(STDOUT)
  end

  def self.logger=(logger)
    @logger = logger
  end

  def self.setup_logger(*args)
    @logger = ::Logger.new(*args)
    @logger.formatter = ::Logger::Formatter.new 
    @logger.datetime_format = "%Y-%m-%d %H:%M:%S "
    @logger
  end
end


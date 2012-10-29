module Safe
  module Logger
     module LogMethods
       def log
         return @logger if @logger
         class_prefix = self.to_s
         # Q: Hey dude, why don't you just use Safe.logger.progname?
         # A: Because thread safety
         @logger = PrefixedLogger.new Safe.logger, class_prefix
       end
     end

     def self.included(klass)
       klass.send :include, LogMethods
       klass.send :extend, LogMethods
     end
  end
end

module Safe
  
   class PrefixedLogger
     def initialize(logger, prefix)
       @logger = logger
       @prefix = prefix + ' : '
     end

     # OK, I feel bad about this repetition below.
     # But define_method won't define method with block argument,
     # and I don't feel like using eval. Feel free to improve

     def debug(progname = nil, &block)
       @logger.add(::Logger::DEBUG, nil, @prefix + progname.to_s, &block)
     end

     def info(progname = nil, &block)
       @logger.add(::Logger::INFO, nil, @prefix + progname.to_s, &block)
     end

     def warn(progname = nil, &block)
       @logger.add(::Logger::WARN, nil, @prefix + progname.to_s, &block)
     end

     def error(progname = nil, &block)
       @logger.add(::Logger::ERROR, nil, @prefix + progname.to_s, &block)
     end

     def fatal(progname = nil, &block)
       @logger.add(::Logger::FATAL, nil, @prefix + progname.to_s, &block)
     end

     def unknown(progname = nil, &block)
       @logger.add(::Logger::UNKNOWN, nil, @prefix + progname.to_s, &block)
     end

   end
end

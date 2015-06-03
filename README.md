Catcher
====

Everytime you create a thread in ruby, you need to add some exception handling to know if something goes wrong (and what exactly went wrong). Same when you do background processing, unless you are already using some bigger framework for this. This gem helps you with that. No fireworks, just makes you write fewer lines to catch and log an exception. 

First, somewhere in initialization you decide where to log:

    Catcher.setup_logger "shit_happens.log"

Arguments are the same as for Logger.new. If you don't setup logger it defaults to STDOUT.

Then in your classes:

    class Foo
      include Catcher::Logger

      def self.bar
        log.info "gangnam style" # wow, this gem is old
      end
    end

It could also be an instance method. It will produce something like this:

    I, [2012-10-30 10:56:45 #20295]  INFO -- : Foo : gangnam style

So by default you have timestamps (how could you live without them?!), and class name because you don't like to repeat yourself. Now the catching stuff:

    Catcher.block "I'm gonnna do science here" do
      raise "oops"
    end

Exception gets catched and logged like this:

    E, [2012-10-30 11:00:32 #23305] ERROR -- : Exception raised by 'I'm gonnna do science here'
      [RuntimeError] oops
      (irb):3:in `block in irb_binding'
      /comboy/projects/os/catcher/lib/catcher.rb:9:in `block'
      (irb):2:in `irb_binding'
      (.. full backtrace here ..)

And finally, for threads, just use:

    Catcher.thread "doing science" do
      # your stuff in a thread
    end

Which is equal to Thread.new with Catcher.block inside.

Description strings in Catcher.block and Catcher.thread are optional, but very much recommended. Comments and suggestions are welome.

Happy threading.

Usage
------

In your Gemfile:

    gem 'catcher'

Author
-------

Kacper Cieśla (comboy)

License
-------

Catcher is released under the MIT license.



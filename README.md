Safe
====

Everytime you create a thread in ruby, you need to add some exception handling to know if something goes wrong (and what exactly went wrong). Similary when you do background processing unless you already use some bigger framework for this. And when you have multiple threads, each one doing something that may or may not succeed, that's where you really appreciate logging done well.

This gem encapsulates pattern I use. First, somewhere in initialization you decide where to log:

    Safe.setup_logger "shit_happens.log"

Arguments are the same as for Logger.new. Then in your classes:

    class Foo
      include Safe::Logger

      def self.bar
        log.info "gangnam style"
      end
    end

It could be also instance method. It will produce something like this:

    I, [2012-10-30 10:56:45 #20295]  INFO -- : Foo : gangnam style

So by default you have timestamps (how could you live without them?!), and class name because you don't like to repeat yourself. Now the catching stuff:

    Safe.block "I'm gonnna do science here" do
      raise "oops"
    end

Exception gets catched and logged like this:

    E, [2012-10-30 11:00:32 #23305] ERROR -- : Exception raised by 'I'm gonnna do science here'
      [RuntimeError] oops
      (irb):3:in `block in irb_binding'
      /comboy/projects/os/safe/lib/safe.rb:9:in `block'
      (irb):2:in `irb_binding'
      (.. full backtrace here ..)

And finally forget about Thread.new, just use:

    Safe.thread "doing science" do
      # your stuff
    end

Which is equal to Thread.new with Safe.block inside.

Description strings in Safe.block and Safe.thread are optional, but very much recommended. Comments and suggestions are very much welome.

Happy threading.

Usage
------

In your Gemfile:

    gem 'safe'

Author
-------

Kacper Cieśla

License
-------

Safe is released under the MIT license.



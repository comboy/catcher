require 'test_helper'
require 'safe'

class TestClass
  include Safe::Logger

  def foo
    log.info "instance method"
  end

  def self.foo
    log.info "class method"
  end
end

describe Safe::Logger do
  before do
    @output = ""
    io = StringIO.new @output
    Safe.setup_logger io
  end

  it "works with instance methods" do
    TestClass.new.foo
    @output.strip.must_match /I, \[(.*)\] *INFO -- : #<TestClass:0x[a-z0-9]+> : instance method$/
  end

  it "works with class methods" do
    TestClass.foo
    @output.strip.must_match /I, \[(.*)\] *INFO -- : TestClass : class method$/
  end

  # TODO test coverage other log methods (debug, fatel etc.)
end

require 'test_helper'

describe Safe do

  it { Safe.logger.wont_be_nil }
  it { Safe.logger.must_be_kind_of Logger }
  let(:output) { "" }
  let(:io) { StringIO.new output }

  describe "logger=" do
    before do
      @logger = Logger.new(nil)
      Safe.logger = @logger
    end

    it { assert_equal Safe.logger, @logger }
  end

  it "formats logs properly" do
    Safe.setup_logger io
    Safe.logger.info "foo"
    output.strip.must_match /I, \[(.*)\] *INFO -- : foo$/
  end

  describe ".thread" do
    it "returns thread" do
      t = Safe.thread { sleep 0.1 }
      t.must_be_kind_of Thread
    end

    it "executes" do
      a = 1
      Safe.thread("my thread") { a = 2 }.join
      a.must_equal 2
    end

    it "executes without description" do
      a = 1
      Safe.thread { a = 2 }.join
      a.must_equal 2
    end
  end

  describe ".block" do
    before { Safe.setup_logger io }

    it "does not raise and logs exception" do
      Safe.block("something") { raise "boom" }
      output.must_match /E, \[(.*)\] *ERROR -- : Exception raised by 'something'/m
    end

    it "workns without description" do
      a = 1
      Safe.block { a = 2 }
      assert_equal a, 2
    end

  end

  it "logs exception" do
    ex = nil
    begin; raise "the hell"; rescue => e; ex = e; end
    ex.must_be_kind_of RuntimeError

    Safe.setup_logger io
    Safe.log_exception(ex, "from here")
    output.must_match /E, \[(.*)\] *ERROR -- : Exception raised by 'from here'/m
    output.must_match /\[RuntimeError\] the hell/m
    output.must_match /safe\/test\/safe_test\.rb:\d+/m
  end

end

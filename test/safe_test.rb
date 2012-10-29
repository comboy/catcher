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

end

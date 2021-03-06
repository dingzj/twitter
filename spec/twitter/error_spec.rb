require 'helper'

describe Twitter::Error do

  describe "#ratelimit_reset" do
    it "should return a Time when X-RateLimit-Reset header is set" do
      error = Twitter::Error.new("Error", {'X-RateLimit-Reset' => "1339019097"})
      error.ratelimit_reset.should be_a Time
      error.ratelimit_reset.should == Time.at(1339019097)
    end
    it "should return nil when X-RateLimit-Reset header is not set" do
      error = Twitter::Error.new("Error", {})
      error.ratelimit_reset.should be_nil
    end
  end

  describe "#ratelimit_class" do
    it "should return a String when X-RateLimit-Class header is set" do
      error = Twitter::Error.new("Error", {'X-RateLimit-Class' => "api"})
      error.ratelimit_class.should be_an String
      error.ratelimit_class.should == "api"
    end
    it "should return nil when X-RateLimit-Class header is not set" do
      error = Twitter::Error.new("Error", {})
      error.ratelimit_class.should be_nil
    end
  end

  describe "#ratelimit_limit" do
    it "should return an Integer when X-RateLimit-Limit header is set" do
      error = Twitter::Error.new("Error", {'X-RateLimit-Limit' => "150"})
      error.ratelimit_limit.should be_an Integer
      error.ratelimit_limit.should == 150
    end
    it "should return nil when X-RateLimit-Limit header is not set" do
      error = Twitter::Error.new("Error", {})
      error.ratelimit_limit.should be_nil
    end
  end

  describe "#ratelimit_remaining" do
    it "should return an Integer when X-RateLimit-Remaining header is set" do
      error = Twitter::Error.new("Error", {'X-RateLimit-Remaining' => "149"})
      error.ratelimit_remaining.should be_an Integer
      error.ratelimit_remaining.should == 149
    end
    it "should return nil when X-RateLimit-Remaining header is not set" do
      error = Twitter::Error.new("Error", {})
      error.ratelimit_remaining.should be_nil
    end
  end

  describe "#retry_after" do
    before do
      Timecop.freeze(Time.utc(2012, 6, 6, 17, 22, 0))
    end
    after do
      Timecop.return
    end
    it "should return an Integer when X-RateLimit-Reset header is set" do
      error = Twitter::Error.new("Error", {'X-RateLimit-Reset' => "1339019097"})
      error.retry_after.should be_an Integer
      error.retry_after.should == 15777
    end
    it "should return nil when X-RateLimit-Reset header is not set" do
      error = Twitter::Error.new("Error", {})
      error.retry_after.should be_nil
    end
  end

end

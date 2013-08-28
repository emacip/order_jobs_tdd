#coding: utf-8
require "#{File.dirname(__FILE__)}/../lib/job"

describe Job do
  it "is invalid without a name" do
    expect{
      Job.new
    }.to raise_error(ArgumentError)
  end

  it "cannot depend on itself" do
    expect{
      Job.new("a", "a")
    }.to raise_error(ArgumentError)
  end

  it "returns it's name when asked" do
    Job.new(:test).name.should be :test
  end

  context "without a dependancy" do
    it "returns nil dependancy" do
      Job.new(:test).dependancy.should be_nil
    end
  end

  context "when a dependancy is supplied" do
    it "returns the dependancy when asked" do
      Job.new(:test, :dep).dependancy.should eq(:dep)
    end
  end
end
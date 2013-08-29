require "#{File.dirname(__FILE__)}/../lib/checkout"
#require "#{File.dirname(__FILE__)}/../lib/"

describe Checkout do
  context "When I pass no jobs" do
    it "returns an empty collection" do
      Checkout.process("").should eq([])
    end
  end

  context "when I pass a single job" do
    it "returns the job to be run" do
      Checkout.process("a => ").should eq(["a"])
    end
  end

  context "multiple jobs, single dependancy" do
    let(:job_spec){ "a =>
                     b => c
                     c =>" }
    it "puts c before b" do
      jobs = Checkout.process(job_spec)
      jobs.join.should =~ /c.*b/
    end
  end

  context "multiple jobs, multiple dependancies" do
    let(:jobs){ Checkout.process("a =>
                                     b => c
                                     c => f
                                     d => a
                                     e => b
                                     f => ")}
    it "puts f before c" do
      jobs.join.should =~ /f.*c/
    end

    it "puts c before b" do
      jobs.join.should =~ /c.*b/
    end

    it "puts b before e" do
      jobs.join.should =~ /b.*e/
    end

    it "puts a before d" do
      jobs.join.should =~ /a.*d/
    end

    it "contains all six letters" do
      jobs.length.should be(6)
    end
  end

  context "self referential jobs" do
    let(:job_spec){ "a =>
                     b => c
                     c => f
                     d => a
                     e =>
                     f => b"}
    it "raises an Error" do
      expect {
        Checkout.process(job_spec)
      }.to raise_error(StandardError)
    end
  end
end
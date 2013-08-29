require "#{File.dirname(__FILE__)}/../lib/jobparser"

describe JobParser do
  let(:parsed_job) { JobParser.parse("a => b") }


  context "when given a single job" do
    it "indexes the collection by the jobname" do
      parsed_job.keys.should include("a")
      parsed_job.keys.length.should be(1)
    end

    it "stores jobs in the collection" do
      parsed_job["a"].should be_a(Job)
    end

    it "names the job correctly" do
      parsed_job["a"].name.should eq("a")
    end

    it "sets up the correct dependancy" do
      parsed_job["a"].dependancy.should eq("b")
    end

  end

  context "with multiple jobs" do
    let(:parsed_jobs){ JobParser.parse("a => b
                                        b =>
                                        c => ")}

    it "creates the correct number of jobs" do
      parsed_jobs.length.should be(3)
    end

    it "parses the args correctly" do
      parsed_jobs.values.map(&:name).should =~ ["a", "b", "c"]
    end
  end
end
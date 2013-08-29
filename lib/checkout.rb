class Checkout
  def self.process(jobs_spec)
    @joblist = JobParser.parse(jobs_spec)
    sort!(JobParser.parse(jobs_spec))
  end

  def self.cyclic_dependancy_in(jobs)
    jobs.each do |job_name, job|
      dep_chain = Set.new

      while(job = jobs[job.dependancy])
        break if !job.dependancy
        if dep_chain.add?(job.name).nil?
          return true
        end
      end
    end
    return false
  end

  def self.sort!(jobs)
    raise(StandardError) if cyclic_dependancy_in(jobs)

    jobs.values.inject([]) { |sorted_jobs, job|
      if !sorted_jobs.include? job.name
        sorted_jobs << job.name
      end
      if job.dependancy
        sorted_jobs.delete(job.dependancy)
        job_pos = sorted_jobs.index(job.name)
        sorted_jobs.insert(job_pos, job.dependancy)
      end
      sorted_jobs
    }
  end
end
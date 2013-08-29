class JobParser
  def self.parse(job_spec)
    job_spec.split("\n").inject(Hash.new){ |acc, spec_line|
      j = Job.new(*spec_line.split('=>').map(&:strip))
      acc[j.name] = j
      acc
    }
  end
end
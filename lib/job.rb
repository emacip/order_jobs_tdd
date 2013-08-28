class Job
  attr_accessor :name, :dependancy

  def initialize(name, dep=nil)
    raise ArgumentError.new("Jobs cannot be blank") if name.nil?
    raise ArgumentError.new("Jobs cannot depend on themselves") if name == dep
    @name =name
    @dependancy = dep == "" ? nil :dep
  end

end
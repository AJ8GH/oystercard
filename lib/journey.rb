class Journey
  attr_reader :entry_station
  attr_accessor :exit_station

  PENALTY = 6
  def initialize(args = {})
    @entry_station = args[:entry_station]
    @exit_station = args[:exit_station]
  end

  def complete?
    entry_station && exit_station
  end


  def fare
    return PENALTY unless complete?
    [@entry_station.zone,@exit_station.zone].sort.inject(:-) #do sort method properly like a <=> b or something like that
  end

end

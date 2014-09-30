require 'pry'

class RouterModel

  attr_accessor :stops, :valid
  attr_reader :connections_to_strings

  @@routes = {
    redlineA: ["Alewife","Davis","Porter","Harvard","Central","Kendall/MIT","Charles/MGH","Park Street","Downtown Crossing","South Station", "Broadway", "Andrew", "JFK/UMASS", "Savin Hill","Fields Corner","Shawmut","Ashmont"],
    redlineB: ["Alewife","Davis","Porter","Harvard","Central","Kendall/MIT","Charles/MGH","Park Street","Downtown Crossing","South Station", "Broadway", "Andrew", "JFK/UMASS", "North Quincy", "Wollaston", "Quincy Center", "Quincy Adams","Braintree"],
    greenlineB: ["Park Street","Boylston","Arlington","Copley","Hynes Convention Center", "Kenmore","Blandford Street","BU East", "BU Central", "BU West", "St. Paul Street", "Pleasant Street", "Babcock Street", "Packards Corner", "Harvard Avenue", "Griggs Street", "Allston Street", "Warren Street", "Washington Street", "Sutherland Road", "Chiswick Road", "Chestnut Hill Avenue", "South Street", "Boston College"],
    greenlineC: ["North Station","Haymarket","Government Center","Park Street","Boylston","Arlington","Copley","Hynes Convention Center", "Kenmore","St. Marys Street", "Hawes Street", "Kent Street", "St. Paul Street", "Coolidge Corner", "Summit Avenue", "Brandon Hall", "Fairbanks Street", "Washington Square", "Tappan Street", "Dean Road", "Englewood Avenue", "Cleveland Circle"],
    greenlineD: ["Park Street","Boylston","Arlington","Copley","Hynes Convention Center", "Kenmore","Fenway", "Longwood", "Brookline Village", "Brookline Hills", "Beaconsfield", "Reservoir", "Chestnut Hill", "Newton Centre", "Newton Highlands", "Eliot", "Waban", "Woodland", "Riverside"],
    greenlineE: ["Lechmere", "Science Park","North Station","Haymarket","Government Center","Park Street","Boylston","Arlington","Copley","Prudential", "Symphony", "Northeastern", "Museum Of Fine Arts", "Longwood Medical Area", "Brigham Circle", "Fenwood Road", "Mission Park", "Riverway", "Back Of The Hill", "Heath"],
    orangeline: ["Oak Grove", "Malden Center", "Wellington", "Assembly","Sullivan Square", "Community College", "North Station","Haymarket","State","Downtown Crossing","Chinatown","Tufts Medical Center","Back Bay", "Mass Ave", "Ruggles", "Roxbury Crossing", "Jackson Square", "Stony Brook", "Green Street", "Forest Hills"],
    blueline: ["Bowdoin", "Government Center", "State","Aquarium", "Maverick", "Airport", "Wood Island", "Orient Heights", "Suffolk Downs", "Beachmont", "Revere Beach", "Wonderland"],
    silverline1: ["South Station", "Courthouse", "World Trade Center", "Silver Line Way", "Terminal A", "Terminal B", "Terminal C", "Terminal E"],
    connections: {
      park_street: [:redlineA, :redlineB,:greenlineB,:greenlineC,:greenlineD,:greenlineE],
      haymarket: [:greenlineC,:greenlineE,:orangeline],
      boylston: [:greenlineB, :greenlineC, :greenlineD, :greenlineE],
      arlington: [:greenlineB, :greenlineC, :greenlineD, :greenlineE],
      copley: [:greenlineB, :greenlineC, :greenlineD, :greenlineE],
      hynes_convention_center: [:greenlineB, :greenlineC, :greenlineD],
      kenmore: [:greenlineB, :greenlineC, :greenlineD],
      downtown_crossing: [:redlineA, :redlineB,:orangeline],
      north_station: [:greenlineC,:greenlineE,:orangeline],
      state: [:orangeline, :blueline],
      government_center: [:greenlineC, :greenlineE, :blueline],
      south_station: [:redlineA,:redlineB, :silverline]
    }
  }

  # this should be returning an array = ["",""]
  def initialize(stops:)
   @stops = stops.scan(/\b[\w\s\/]+/im)
   convert_to_proper
  end

  def convert_to_proper
    origin = @stops[0].scan(/\b[a-z][\w\s\/]+/i)[0].split.map(&:capitalize)*' '
    destination = @stops[1].scan(/\b[a-z][\w\s\/]+/i)[0].split.map(&:capitalize)*' '
    origin.sub!(/[\/]+[A-Za-z]+/){ $&.upcase }
    destination.sub!(/([\/])\w+/){ $&.upcase }
    origin.sub!(/(?: *town)/i, "town")
    destination.sub!(/(?: *town)/i, "town")
    @stops.replace([origin,destination])
    validate_stops(origin, destination)
  end

  def validate_stops(origin, destination)
    origin_valid = false
    destination_valid = false
    @@routes.each_pair { |k,v|
      if v.include?(@stops[0])
        origin_valid = true
      elsif v.include?(@stops[1])
        destination_valid = true
      end
    }
    @valid = origin_valid && destination_valid
  end


end

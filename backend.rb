class Team
  attr_accessor :name
  attr_accessor :endpoints
  def initialize(name)
    @name = name
    @endpoints = []
  end
  
  def find_endpoint_by_service_name(service_name)
    @endpoints.each {|endpoint| return endpoint if endpoint.service_name == service_name}
  end

  def find_host_by_service_name(service_name)
    @endpoints.each {|endpoint| return endpoint if endpoint.service_name == service_name}
  end
  
  
end

class Endpoint
  attr_accessor :addresss
  attr_accessor :service_name
  attr_accessor :state

  def initialize(address, service_name, state)
    @address = address
    @service_name = service_name
    @state = state
  end
end

class Watcher

  def initialize
    @teams = []

    #
    # Add the appropriate host to each team
    #
    configure_teams
    parse_xml
  end
  
  def find_team_by_name(name)
    @teams.each {|team| return team if team.name == name }
  end

  def parse_xml
    #
    # For each service file, open and parse - set the appropriate flag
    ["http", "https", "ftp", "mysql", "smb_139", "smb_445"].each do |service_name|
      lines = File.open("#{File.dirname(__FILE__)}/data/#{service_name}.gnmap").read.split("\n")
      lines.each do |line|
        @teams.each do |team|
          if line =~ team.find_host_by_service_name(service_name)
            team.find_endpoint_by_service_name(service_name).state = true
          end
        end
      end
    end

  end

  def configure_teams
      #
      # Team 1 
      #
      @team1 = Team.new("team1")
      @team1.endpoints << Endpoint.new("10.0.0.11","http",false)
      @team1.endpoints << Endpoint.new("10.0.0.11","https",false)
      @team1.endpoints << Endpoint.new("10.0.0.11","ftp",false)
      @team1.endpoints << Endpoint.new("10.0.0.11","mysql",false)
      @team1.endpoints << Endpoint.new("10.0.0.11","smb_139",false)
      @team1.endpoints << Endpoint.new("10.0.0.11","smb_445",false)
      @teams << @team1

  end

end

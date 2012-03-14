require 'nmap/parser'

class Team
  attr_accessor :endpoints
  def initialize()
    @endpoints = []
  end
  
  def find_endpoint_by_service_name(service_name)
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
    @nmap_parser = Nmap::Parser.new

    #
    # Add the appropriate host to each team
    #
    configure_teams
    parse_xml
  end

  def parse_xml
    #
    # For each service file, open and parse - set the appropriate flag
    @nmap_parser.parsefile("File.dirname(__FILE__)/../data/http.xml")
    @nmap_parser.hosts("up")
      
  
  end

  def configure_teams
      #
      # Team 1 
      #
      @team1.endpoints << Endpoint.new("10.0.0.11","http",false)
      @team1.endpoints = Endpoint.new("10.0.0.11","https",false)
      @team1.endpoints = Endpoint.new("10.0.0.11","ftp",false)
      @team1.endpoints = Endpoint.new("10.0.0.11","mysql",false)
      @team1.endpoints = Endpoint.new("10.0.0.11","smb_139",false)
      @team1.endpoints = Endpoint.new("10.0.0.11","smb_139",false)
      @teams << @team1

  end

end

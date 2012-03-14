require 'fileutils'

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
    @endpoints.each {|endpoint| return endpoint.address if endpoint.service_name == service_name}
  end
end

class Endpoint
  attr_accessor :address
  attr_accessor :service_name
  attr_accessor :state

  def initialize(address, service_name, state)
    @address = address
    @service_name = service_name
    @state = state
  end
end

require 'singleton'

class Watcher
  include Singleton

  attr_accessor :teams
  
  def initialize
    @teams = []
    setup_teams
    clear_data_dir
    start_scan_thread "http", 80
    start_scan_thread "https", 443
    start_scan_thread "ftp", 21
    start_scan_thread "mysql", 3306
    start_scan_thread "smb_139", 139
    start_scan_thread "smb_445", 445
  end

  def watch
    parse_scans
  end
  
  def clear_data_dir
    Dir["#{File.dirname(__FILE__)}/data/*.gnmap"].each{ |file| FileUtils.rm file }
  end
  
  def start_scan_thread(service_name, service_port)
    service_hosts = []
    @teams.each{ |t| service_hosts << t.find_host_by_service_name(service_name) }
    Thread.new do
      f = File.open("#{File.dirname(__FILE__)}/log/#{service_name}_scan.log", "w")
      while true do
        f.puts "scanning #{service_hosts.join(",")} for #{service_name}"
        #
        # Set up the nmap command line
        #
        command_line = "nmap -p #{service_port} #{service_hosts.join(" ")} -oG data/#{service_name}.gnmap"
  
        f.puts "command line: #{command_line}"
        #
        # and ... run it
        #
        f.puts `#{command_line}`
        f.flush
        #
        # hang out for a minute
        #
        sleep 60
      end
    end
  end

  
  def find_team_by_name(name)
    @teams.each {|team| return team if team.name == name }
  end

  def parse_scans
    #
    # For each service
    #
    ["http", "https", "ftp", "mysql", "smb_139", "smb_445"].each do |service_name|
      #
      # Open up a file for this service
      #
      lines = File.open("#{File.dirname(__FILE__)}/data/#{service_name}.gnmap").read.split("\n")
      lines.each do |line|
        # 
        # Go through each team
        #
        @teams.each do |team|
          #
          # First check to see that we found the host
          #
          if line =~ /#{team.find_host_by_service_name(service_name)}/
            #
            # Then check to see if it's open
            #
            if line =~ /open/
              team.find_endpoint_by_service_name(service_name).state = true
            #
            # Otherwise set it back to closed
            #
            else
              team.find_endpoint_by_service_name(service_name).state = false
            end
          end
        end
      end
    end
  end

  def setup_teams
      #
      # Team 1 
      #
      team = Team.new("team1")
      team.endpoints << Endpoint.new("10.0.0.11","http",false)
      team.endpoints << Endpoint.new("10.0.0.11","https",false)
      team.endpoints << Endpoint.new("10.0.0.11","ftp",false)
      team.endpoints << Endpoint.new("10.0.0.11","mysql",false)
      team.endpoints << Endpoint.new("10.0.0.11","smb_139",false)
      team.endpoints << Endpoint.new("10.0.0.11","smb_445",false)
      @teams << team

      #
      # Team 2
      #
      team = Team.new("team2")
      team.endpoints << Endpoint.new("10.0.0.250","http",false)
      team.endpoints << Endpoint.new("10.0.0.250","https",false)
      team.endpoints << Endpoint.new("10.0.0.250","ftp",false)
      team.endpoints << Endpoint.new("10.0.0.250","mysql",false)
      team.endpoints << Endpoint.new("10.0.0.250","smb_139",false)
      team.endpoints << Endpoint.new("10.0.0.250","smb_445",false)
      @teams << team

      #
      # Team 3
      #
      team = Team.new("team3")
      team.endpoints << Endpoint.new("10.0.0.1","http",false)
      team.endpoints << Endpoint.new("10.0.0.1","https",false)
      team.endpoints << Endpoint.new("10.0.0.1","ftp",false)
      team.endpoints << Endpoint.new("10.0.0.1","mysql",false)
      team.endpoints << Endpoint.new("10.0.0.1","smb_139",false)
      team.endpoints << Endpoint.new("10.0.0.1","smb_445",false)
      @teams << team

      #
      # Team 4
      #
      team = Team.new("team4")
      team.endpoints << Endpoint.new("10.0.0.93","http",false)
      team.endpoints << Endpoint.new("10.0.0.93","https",false)
      team.endpoints << Endpoint.new("10.0.0.93","ftp",false)
      team.endpoints << Endpoint.new("10.0.0.93","mysql",false)
      team.endpoints << Endpoint.new("10.0.0.93","smb_139",false)
      team.endpoints << Endpoint.new("10.0.0.93","smb_445",false)
      @teams << team

      #
      # Team 5
      #
      team = Team.new("team5")
      team.endpoints << Endpoint.new("10.0.0.11","http",false)
      team.endpoints << Endpoint.new("10.0.0.11","https",false)
      team.endpoints << Endpoint.new("10.0.0.11","ftp",false)
      team.endpoints << Endpoint.new("10.0.0.11","mysql",false)
      team.endpoints << Endpoint.new("10.0.0.11","smb_139",false)
      team.endpoints << Endpoint.new("10.0.0.11","smb_445",false)
      @teams << team

      #
      # Team 6
      #
      team = Team.new("team6")
      team.endpoints << Endpoint.new("10.0.0.11","http",false)
      team.endpoints << Endpoint.new("10.0.0.11","https",false)
      team.endpoints << Endpoint.new("10.0.0.11","ftp",false)
      team.endpoints << Endpoint.new("10.0.0.11","mysql",false)
      team.endpoints << Endpoint.new("10.0.0.11","smb_139",false)
      team.endpoints << Endpoint.new("10.0.0.11","smb_445",false)
      @teams << team

      #
      # Team 7
      #
      team = Team.new("team7")
      team.endpoints << Endpoint.new("10.0.0.11","http",false)
      team.endpoints << Endpoint.new("10.0.0.11","https",false)
      team.endpoints << Endpoint.new("10.0.0.11","ftp",false)
      team.endpoints << Endpoint.new("10.0.0.11","mysql",false)
      team.endpoints << Endpoint.new("10.0.0.11","smb_139",false)
      team.endpoints << Endpoint.new("10.0.0.11","smb_445",false)
      @teams << team

      #
      # Team 8
      #
      team = Team.new("team8")
      team.endpoints << Endpoint.new("10.0.0.11","http",false)
      team.endpoints << Endpoint.new("10.0.0.11","https",false)
      team.endpoints << Endpoint.new("10.0.0.11","ftp",false)
      team.endpoints << Endpoint.new("10.0.0.11","mysql",false)
      team.endpoints << Endpoint.new("10.0.0.11","smb_139",false)
      team.endpoints << Endpoint.new("10.0.0.11","smb_445",false)
      @teams << team

  end
  
  
  

end

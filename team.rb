class Team

  attr_accessor :http_up
  attr_accessor :https_up
  attr_accessor :ftp_up
  attr_accessor :mysql_up
  attr_accessor :smb_139_up
  attr_accessor :smb_445_up

  def initialize(range="10.0.0.0/24")
    @http_up = false
    @https_up = false
    @ftp_up = false
    @mysql_up = false
    @smb_139_up = false
    @smb_445_up = false
    
    @range = range
  end
  
  def parse
    
  end
  
end

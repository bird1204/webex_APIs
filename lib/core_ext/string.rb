require 'active_support/core_ext/hash'
class String
  def stringify_string
    hash = Hash.from_xml(self)
    "ST=#{hash['ListOpenMeetings']['Status']}&RS=#{hash['ListOpenMeetings']['Reason']}&MeetingKeys=#{hash['ListOpenMeetings']['MeetingKeys']}"
  rescue
    match(/(var url = |window.location.replace\()\"(.*)\"/)[2].gsub!('\\x3a',':').gsub!('\\x2f','/').gsub!('\\x3f','?').gsub!('\\x3d','=').gsub!('\\x26','&').split('?').last
  end
end

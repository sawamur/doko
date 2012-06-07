# -*- coding: utf-8 -*-
# -*- code:utf-8 -*-

require 'nokogiri'
require 'open-uri'
require 'uri'

class Doko
  def self.parse(str)
    self.new(str).parse
  end

  def initialize(str)
    if str.match( /^#{URI.regexp}$/ )
      str = open(str).read
    end
    @doc =  Nokogiri::HTML(str)
  end
  
  def parse
    body = (@doc/"body").text
    body.tr!("０-９","0-9")
    body.tr!("ー","-")
    body.tr!("（）","()")
    body.tr!("、",",")
    
    addrs = body.scan(/([^\s,()]{2,8}(都|道|府|県)[^\s,()]{1,8}(市|区|町|村).+)/).map{ |m|
      line = m[0]
      line.gsub!(/住所(\s|\n)?/,"")
      line.gsub!(/〒\d{3}-\d{4}　?/,"")
      line.gsub!(/\s+$/,"")
      line.gsub!(/\s?電話:.+$/,"")
      line
    }
    if addrs.empty?
      addrs = body.scan(/([^\s]+(市|区).{2,8}(町|村).{2,10}\d)/).map{ |m|
        line = m[0]
        line.gsub!(/住所(\s|\n)?/,"")
        line.gsub!(/〒\d{3}-\d{4}　?/,"")
        line.gsub!("[MAP]","")
        line.gsub!(/(TEL|FAX):\d{2,4}-\d{2,4}-\d{2,4}/,"")
        line
      }
    end
    addrs
  end
end



            

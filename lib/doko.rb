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
    if str.match(/<html/i)
      @text =  (Nokogiri::HTML(str)/"body").text
    else
      @text = str
    end
  end
  
  def parse
    body = @text
    body.tr!("０-９","0-9")
    body.tr!("（）","()")
    body.tr!("、",",")
    body.tr!("　"," ")
    body.tr!("．",".")
    blackchars =  ",()\n"

    addrs = body.scan(/\b([^\s,()]{2,3}(都|道|府|県)[^\s,()]{1,8}(市|区|町|村)[^#{blackchars}]+)/).map{ |m|
      clean(m[0])
    }
    if addrs.empty?
      addrs = body.scan(/([^\s]{1,6}(市|区).{2,8}(区|町|村)[^\s,()]{2,10}\d)/).map{ |m|
        clean(m[0])
      }
    end
    addrs.select{ |a|
      !a.match(/を/)
    }
  end

  private


  def clean(line)
    line.gsub!(/住所(\s|\n)?/,"")
    line.gsub!(/〒\d{3}-\d{4}　?/,"")
    line.gsub!(/\s+$/,"")
    line.gsub!(/\s?電話:.+$/,"")
    line.gsub!("[MAP]","")
    line.gsub!(/(TEL|FAX):\d{2,4}-\d{2,4}-\d{2,4}/,"")
    line.gsub!(/(\dー)*\d/) do |t|
      t.tr("ー","-")
    end
    line
  end
end



            

# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'open-uri'

describe "Doko" do

  it "should retrieve address from string"  do
    Doko.parse("ここは\n東京都港区芝浦3-4-1\nです").first.should == "東京都港区芝浦3-4-1"
  end

  it "should retrieve address from html" do
    addrs = Doko.parse(open("http://r.tabelog.com/tokyo/A1304/A130401/13130066/").read)
    addrs.first.should == "東京都新宿区新宿3-38-1 ルミネエスト7F"
  end

  it "should return addr from tabelog url" do
      addrs = Doko.parse("http://r.tabelog.com/kanagawa/A1401/A140104/14001924/")
      addrs.first.should == "神奈川県横浜市中区海岸通1-1"
  end
  
  it "should return from 30min" do
    addrs = Doko.parse("http://30min.jp/place/23481")
    addrs.first.should == "東京都墨田区業平1-21-4 第2刀川ビル1F"
  end

  it "should return addr from site 1" do
    Doko.parse("http://thanikitchen.com/")[0] == "東京都品川区南大井6-11-10"
    Doko.parse("http://thanikitchen.com/")[1] == "東京都品川区大井7-29-8"
  end

  it "should return addr in kyoto" do
    addrs = Doko.parse("http://www.tripadvisor.jp/Hotel_Review-g298564-d2317992-Reviews-Royal_Park_Hotel_The_Kyoto-Kyoto_Kyoto_Prefecture_Kinki.html")
    addrs.first.should == "京都府京都市中京区三条通河原町東入ル"
  end

  it "should return addr in kumamoto" do
    addrs = Doko.parse("http://travel.rakuten.co.jp/HOTEL/68236/68236_std.html")
    addrs.first.should == "熊本県阿蘇郡南阿蘇村河陽4673-18"
  end

  it do
    Doko.parse("http://www.ynu.ac.jp/index.html").first.should == "神奈川県横浜市保土ケ谷区常盤台79-1"
  end

  it do
    Doko.parse("http://www.nissan-stadium.jp/").first.should == "横浜市港北区小机町3300"
  end

  it do
    Doko.parse("http://atnd.org/events/28384").first.should == "東京都千代田区神田駿河台2-3 DH2001Bldg."
  end
end

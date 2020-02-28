require 'spec_helper'
include UserHelper

describe UserHelper do
  context "When auto-registering users" do
    before :all do
      User.all.each {|u| auto_register(u, true)}
    end
    it "does not produce duplicate workshops" do
      puts "dups"
    end
    it "registers all users" do
      puts "s"
    end
    it "registers all teachers" do
      puts "t"
    end
  end
end

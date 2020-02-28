require 'spec_helper'
include UserHelper

describe Student, type: :model do
  context "When auto-registering students" do
    before :all do
      Student.all.each {|u| auto_register(u, true)}
    end
    it "does not produce duplicate workshops" do
      puts "dups"
    end
    it "registers all students" do
      puts "s"
    end
  end
end

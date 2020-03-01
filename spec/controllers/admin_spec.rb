require 'spec_helper'

describe 'AdminController', type: :controller do
  before :each do
    basic_authorize ENV['ADMIN_NAME'], ENV['ADMIN_PASS']
  end

  context "When loading code" do
    it "doesn't break" do
      true
    end
  end

  context "When loading page" do
    it "can authorize" do
      r = get("/admin")
      expect(r.status).to eq(200)
    end
  end
  
end

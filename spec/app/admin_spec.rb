require 'spec_helper'

describe "AdminController" do
  before :each do
    basic_authorize ENV['ADMIN_NAME'], ENV['ADMIN_PASS']
  end
  
  it "can authorize" do
    r = get("/admin")
    expect(r.status).to eq(200)
  end
  
end

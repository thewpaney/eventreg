require 'spec_helper'

describe Eventreg::Application do
  context "When accessing root" do
    it "redirects to login" do
      r = get('/')
      expect(r.status).to eq(302)
      expect(r.original_headers["Location"]).to match(/.*\/login/)
    end
  end
end

class User < ActiveRecord::Base
  validates :name, :student_id, presence: true, uniqueness: true
  validates :student_id, :format => /\A\d{5}\z/
  belongs_to :event

  def self.authenticate(n, pass)
    (u = User.where(name: n).first).student_id == pass.to_i ? u : nil
  end
end

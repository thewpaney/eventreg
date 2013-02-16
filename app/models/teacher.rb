class Teacher < ActiveRecord::Base
  attr_accessible :number, :name, :email
  validates :number, presence: true
  validates :name, presence: true
  validates :email, presence: true

  def to_s
    name
  end
end

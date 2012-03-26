class Email < ActiveRecord::Base
  attr_accessible :email, :tag
  validates_presence_of :email, :tag
  validates_format_of :email, with: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}/i, message: "Invalid email address"
end

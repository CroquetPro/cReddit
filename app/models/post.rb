class Post < ActiveRecord::Base
  validates :title, :sub_id, :author_id, presence: true

  belongs_to :sub
  belongs_to :author, class_name: "User"
  has_many :comments

end

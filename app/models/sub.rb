# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  title        :string
#  description  :string
#  moderator_id :integer
#

class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true

  has_many :sub_posts,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: "SubPost",
    inverse_of: :sub

  has_many :posts,
    through: :sub_posts,
    source: :post

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: "User"
    


end

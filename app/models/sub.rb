# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  moderator_id :integer          not null
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

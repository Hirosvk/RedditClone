# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text             not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :content, :author, presence: true
  validates :sub_ids, length: { minimum: 1}

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "User"

  has_many :sub_posts,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: "SubPost",
    inverse_of: :post

  has_many :subs,
    through: :sub_posts,
    source: :sub




end

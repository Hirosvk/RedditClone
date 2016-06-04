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
  validates :sub_ids, length: { minimum: 1, message: "At least one sub needs to be associatd with the post" }

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

  has_many :comments,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: "Comment",
    dependent: :destroy

  def comments_by_parent_id
    hash = {}
    self.comments.includes(:author).each do |comment|
      id = comment.parent_comment_id
      hash[id] = [] if hash[id].nil?
      hash[id] << comment
    end
    hash
  end

end

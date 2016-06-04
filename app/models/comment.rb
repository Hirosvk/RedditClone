# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  author_id         :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  content           :text             not null
#  created_at        :datetime
#  updated_at        :datetime
#

class Comment < ActiveRecord::Base
  validates :author, :post, :content, presence: true

  belongs_to :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: "Post"

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "User",
    inverse_of: :comments

  belongs_to :parent_comment,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: "Comment"

  has_many :child_comments,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: "Comment",
    dependent: :destroy

  def self.top_level_comments
    self.where(parent_comment_id: nil)
  end

end

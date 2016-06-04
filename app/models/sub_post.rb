# == Schema Information
#
# Table name: sub_posts
#
#  id         :integer          not null, primary key
#  sub_id     :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SubPost < ActiveRecord::Base
  validates :sub, :post, :presence => true
  validates :post_id, :uniqueness => {scope: :sub_id}

  belongs_to :sub,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: "Sub"

  belongs_to :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: "Post"

end

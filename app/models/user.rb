# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :password_digest, presence: true

  has_many :authored_posts,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "Post"

  has_many :contributing_subs,
    through: :authored_posts,
    source: :subs

  has_many :moderating_subs,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: "Sub"

  attr_reader :password
  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    return user if user.is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save
  end


  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

end

# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, :password_digest, uniqueness: true
  before_validation :ensure_session_token
  
  has_many :subs,
  primary_key: :id,
  foreign_key: :moderator_id,
  class_name: :Sub
  
  has_many :posts,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :Post
  
  has_many :comments,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :Comment
  
  attr_reader :password
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end
end

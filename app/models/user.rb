class User < ApplicationRecord
  has_secure_password

  before_validation :normalize_email

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }, if: :password_required?

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end

  def password_required?
    new_record? || password.present?
  end
end

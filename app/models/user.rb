class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :created_clubs, class_name: "Club", foreign_key: "created_by_id"
  has_many :club_members, dependent: :destroy
  has_many :clubs, through: :club_members

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 12 }, if: -> { new_record? || !password.nil? }
  validates :role, inclusion: { in: %w[USER ADMIN] }

  has_secure_password

  normalizes :email, with: ->(email) { email.strip.downcase }

  before_create :generate_confirmation_token
  after_create :send_confirmation_instructions


  def confirm!
    update_columns(confirmed_at: Time.current, confirmation_token: nil)
  end

  def confirmed?
    confirmed_at.present?
  end

  private

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
    self.confirmation_sent_at = Time.current
  end

  def send_confirmation_instructions
    UserMailer.confirmation_instructions(self).deliver_now
  end
end

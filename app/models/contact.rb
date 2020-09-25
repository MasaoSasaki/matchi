class Contact < ApplicationRecord

  with_options presence: true do
    validates :email
    validates :message
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, length: {maximum:255}

end

class Contact < ApplicationRecord

  with_options presence: true do
    validates :email
    validates :message
  end

  validates :email, format: { with: ADDRESS_REGEX }, length: { maximum:255 }

end

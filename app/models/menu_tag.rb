class MenuTag < ApplicationRecord

  belongs_to :tag
  belongs_to :menu

  # バリデーション
  with_options numericality: { only_integer: true } do
    validates :menu_id
    validates :tag_id
  end

end

class SavedPost < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :video_post, optional: true
end

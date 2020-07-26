class Tweet < ApplicationRecord
  mount_uploaders :image, ImageUploader
end

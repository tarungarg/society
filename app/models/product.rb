class Product < ActiveRecord::Base
  mount_uploaders :images, AvatarUploader
end

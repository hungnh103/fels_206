class Activity < ApplicationRecord
  belongs_to :user, dependent: :destroy
end

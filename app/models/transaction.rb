class Transaction < ApplicationRecord
  belongs_to :invoice
  scope :success, -> { where(result: 'succes')}
end

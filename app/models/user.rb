class User < ApplicationRecord
  has_one :account_information, dependent: :destroy
  has_many :sales, dependent: :destroy
end

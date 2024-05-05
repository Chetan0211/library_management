class Borrower < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  enum status:{requested: "requested", active: "active", rejected: "rejected", returned: "returned"}
end

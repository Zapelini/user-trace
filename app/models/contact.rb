class Contact < ApplicationRecord
  validates_presence_of :email
  validates :email, presence: true,
            format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create},
            uniqueness: {case_sensitive: false}

  has_many :contacttraces
end


class ContactTrace < ApplicationRecord
  belongs_to :contact
end
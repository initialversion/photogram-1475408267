class FriendRequest < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :status, :presence => true

  validates :status, :inclusion => { :in => [ 'pending', ' accepted', ' declined' ]  }

end

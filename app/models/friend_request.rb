class FriendRequest < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :status, :inclusion => { :in => [ 'pending', ' accepted', ' declined' ]  }

end

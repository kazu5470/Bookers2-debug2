class BookComment < ApplicationRecord
    belongs_to :user
    belongs_to :book
    validates:coment, presence: true
end

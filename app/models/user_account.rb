class UserAccount < ApplicationRecord

	acts_as_tenant(:account)

	belongs_to :user
	belongs_to :account

 end

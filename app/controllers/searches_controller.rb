class SearchesController < ApplicationController
    before_action :authenticate_user!
    
	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.list(@content, @method)
		else
			@records = Book.list(@content, @method)
		end
	end    
end

class SearchesController < ApplicationController
    before_action :authenticate_user!
    
    def search
        @range = params[:range]
        if @range == "user"
            @users = User.search(params[:search], params[:word])
        else
            @books = Book.search(params[:search], params[:word])
        end
    end     
end

class BorrowersController < ApplicationController
    def index
        borrowers = Borrower.all
        render json: borrowers
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Borrowers not found" }, status: :internal_server_error
    end

    def show
        borrower = Borrower.find(params[:id])
        render json: borrower
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Borrower not found" }, status: :not_found
    end
end

class VisitorsController < ApplicationController

  def new
    @visitor = Visitor.new
  end

  def create
    @visitor = Visitor.new(secure_params)
    if @visitor.valid?
      @visitor.subscribe
      flash[:notice] = "Signed up #{@visitor.email}."
    else
      render :new
    #   flash[:alert] = []
	  	# @visitor.errors.full_messages.each do |msg|
	  	# 	flash[:alert] << msg
	  	# end
    end

    redirect_to root_path
	  
  end

  private

  def secure_params
    params.require(:visitor).permit(:email)
  end

end
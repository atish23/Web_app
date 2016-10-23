class SubscribesController < ApplicationController
  before_filter :authenticate_user! 

  def new 
  end 

  def create
    # Get the credit card details submitted by the form 
    token = params[:stripeToken] 

    # Create a Customer 
    customer = Stripe::Customer.create( 
      :source => token, 
      :plan =>  1, 
      :email => current_user.email 
    ) 

    # Save stripe information to the current user using Devise helper
    current_user.subscribed = true 
    current_user.stripeid = customer.id 
    current_user.save 

    # Redirect back to products page with a ‘success’ notice 
    redirect_to root_path, :notice => "Your subscription was 
    successful!" 
  end
end

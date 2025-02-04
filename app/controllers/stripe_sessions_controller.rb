class StripeSessionsController < ApplicationController
  def show
    session_id = params[:session_id]
    begin
      session = Stripe::Checkout::Session.retrieve(session_id)
      render json: {
        id: session.id,
        payment_status: session.payment_status,
        amount_total: session.amount_total,
        currency: session.currency,
      }
    rescue Stripe::InvalidRequestError => e
      # Handle errors if the session ID is invalid or not found
      render json: { error: e.message }, status: 404
    end
  end
end
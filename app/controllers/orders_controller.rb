class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :paypal_init

  def new; end

  def create_order
    price = '100.00'
    request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
    request.request_body({
      intent: 'CAPTURE',
      purchase_units: [
        {
          amount: {
            currency_code: 'USD',
            value: price
          }
        }
      ]
    })
    begin
      response = @client.execute(request)
      @order = Order.new
      @order.cart = current_user.cart
      @order.price = price.to_i
      @order.token = response.result.id
      if @order.save
        render json: { token: response.result.id }, status: :ok
      end
    rescue PayPalHttp::HttpError
      # HANDLE THE ERROR
    end
  end

  def capture_order
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest.new(params[:order_id])
    begin
      response = @client.execute(request)
      @order = Order.find_by(token: params[:order_id])
      @order.paid = response.result.status == 'COMPLETED'
      if @order.save
        render json: { status: response.result.status }, status: :ok
      end
    rescue PayPalHttp::HttpError
      # HANDLE THE ERROR
    end
  end

  private

  def paypal_init
    client_id = ENV['PAYPAL_CLIENT_ID']
    client_secret = ENV['PAYPAL_CLIENT_SECRET']
    environment = PayPal::SandboxEnvironment.new(client_id, client_secret)
    @client = PayPal::PayPalHttpClient.new(environment)
  end
end

class FormController < ApplicationController
  def index
    @contact = Form.new(params[:form])
  end

  def create
    @contact = Form.new(params[:form])
    @contact.request = request
    respond_to do |format|
      if @contact.deliver
        # re-initialize Form object for cleared form
        @contact = Form.new
        format.html { render root_path}
        format.js   { flash.now[:success] = @message = "Thank you for your message. I'll get back to you soon!" }
        redirect_to root_path
      else
        format.html { render root_path }
        format.js   { flash.now[:error] = @message = "Message did not send." }
        redirect_to root_path
      end
    end
  end
end

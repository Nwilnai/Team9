class ContactController < ApplicationController
    require 'mail_form'
    def index
      @contact = Contact.new(params[:contact])
    end
  
    def create
      @contact = Contact.new(params[:contact])
      @contact.request = request
      respond_to do |format|
        if @contact.deliver
          @contact = Contact.new
          format.html { render 'static_pages/home'}
          flash[:success] = "Thank you for your message. We will get back to you soon!"
        else
          format.html { render 'static_pages/home' }
          flash[:error] = "Message did not send. Please check the email you provided."
        end
      end
    end

  end
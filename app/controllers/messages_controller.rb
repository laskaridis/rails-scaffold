class MessagesController < ApplicationController

  # GET /user/messages
  def index
    case params[:q]
    when "inbox" then received
    when "sent" then sent
    when "unread" then unread
    when "spam" then spam
    when "trash" then trash
    else received
    end
  end

  # POST /user/messages
  def create
    @message = Message.new(message_params)
    @message.recipient = current_user
    @message.sender = current_user
    @message.read = true
    
    respond_to do |format|
      if @message.save
        format.json {}
      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
  #
  # DELETE /user/messages/:id
  def destroy
  end

  # GET /user/messages/:id
  def show
  end

  private

  def sent
    @messages = Message.
      sent_by(current_user).
      includes(:recipient).
      order(created_at: :desc)
  end

  def received
    @messages = Message.
      received_by(current_user).
      includes(:recipient).
      order(created_at: :desc)
  end

  def unread
    @messages = Message.
      received_by(current_user).unread.
      includes(:recipient).
      order(created_at: :desc)
  end

  def spam
    @messages = []
  end

  def trash
    @messages = []
  end

  def message_params
    params.fetch(:message, { }).permit(
      :recipient_id,
      :subject,
      :message
    )
  end
end

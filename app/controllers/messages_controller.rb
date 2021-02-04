class MessagesController < ApplicationController
  before_action :set_message, only: [:destroy]
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    session[:return_to] ||= request.referer

    @messages = @conversation.messages

    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
      @messages = @messages[0..@messages.length - 1]
    end

    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
      end
    end

    @message = @conversation.messages.new

    temp_ary = []

    @messages.each do |msg|
      next if msg.id.nil?
      temp_ary << msg
    end

    @messages = temp_ary
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user_id = current_user.id

    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def set_message
    if Message.find(params[:id]).user != current_user
      redirect_to session.delete(:return_to)
    end
  end
end

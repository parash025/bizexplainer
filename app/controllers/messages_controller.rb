class MessagesController < ApplicationController

  def index

  end

  def new
    @message = Message.new
    @user = current_user
  end


  def create
    message = Message.new(message_params)
    message.user_id = current_user.id
    message.read = false
    #project.document_file_name = "User_#{current_user.id.to_s}"+project.document_file_name

    if message.save
      redirect_to :controller => 'projects', :action => 'show', :id => message.project_id.to_s, :redirect => 'yes'
    else
      render 'new'
    end
  end

  def message_params
    params.require(:message).permit(:content,:project_id)
  end


end

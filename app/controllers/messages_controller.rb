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
    #project.document_file_name = "User_#{current_user.id.to_s}"+project.document_file_name

    if message.save
      path = projects_path+'/'+message.project_id.to_s
      redirect_to path, :notice => "Message Sent"
    else
      render 'new'
    end
  end

  def message_params
    params.require(:message).permit(:content,:project_id)
  end


end

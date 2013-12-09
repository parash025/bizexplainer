class ProjectsController < ApplicationController

  before_action :require_login


	def index
		@projects = current_user.projects
	end

  def admin
    @projects = Project.all
  end


	def new
		@project = Project.new
    @user = current_user
    4.times { @project.assets.build }

	end

	def create
		project = Project.new(project_params)
    project.user_id = current_user.id
    #project.document_file_name = "User_#{current_user.id.to_s}"+project.document_file_name.to_s

    if project.save
      redirect_to root_path, :notice => "Project Created Successfully!"
    else
      render 'new'
    end

  end

  def show
    @message = Message.new
    @project_id = params[:id]

    @project = Project.find(@project_id)
    @requirements = @project.requirements
    @assets = @project.assets

    @messages = Message.where(project_id: @project_id).order('created_at ASC')
    @messages.each do |message|
      message.read = true
      message.save
    end

  end

  def project_params
    params.require(:project).permit(:title, :video_duration, :voice_over, :requirements, assets_attributes: [:document])
  end

  private

  def require_login
    redirect_to sign_up_path unless session[:user_id]
  end

end

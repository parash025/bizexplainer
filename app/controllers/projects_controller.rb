class ProjectsController < ApplicationController

  before_action :require_login


	def index
      if admin?
        @projects = Project.all.order(created_at: :desc)
        render :admin
      else
        @projects = current_user.projects
      end

	end

  def admin
    if admin?
      @projects = Project.all.order(created_at: :desc)
    else
      @projects = current_user.projects
      render :index
    end
  end

	def new
		@project = Project.new
    @user = current_user
    4.times { @project.assets.build }

	end

	def create
		project = Project.new(project_params)
    project.user_id = current_user.id
    project.project_status = 'Pending'
    project.payment_status = 'Pending'
    #project.document_file_name = "User_#{current_user.id.to_s}"+project.document_file_name.to_s

    if project.save
      redirect_to root_path, :notice => "Project Created Successfully!"
    else
      render 'new'
    end

  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    redirect_to admin_path
  end

  def update
      project = Project.find(params[:id])
      project.update_attributes update_params
      redirect_to project_path
  end

  def show
    @message = Message.new
    @project_id = params[:id]

    @project = Project.find(@project_id)
    @requirements = @project.requirements
    @project_status = @project.project_status
    @assets = @project.assets
    @deliverables = @project.deliverables

    @messages = Message.where(project_id: @project_id).order('created_at ASC')
    @messages.each do |message|
      message.read = true
      message.save
    end

    1.times { @project.deliverables.build unless @project.deliverables.present?}

  end

  private

  def project_params
    params.require(:project).permit(:title, :video_duration, :voice_over, :requirements, assets_attributes: [:document])
  end

  def update_params
    params.require(:project).permit(:project_status, deliverables_attributes: [:document])
  end

  def require_login
    redirect_to sign_up_path unless session[:user_id]
  end

end

class ProjectsController < ApplicationController

  before_action :require_login


  def index
    if admin?
      @projects = Project.get_all_projects
      render :admin
    else
      @projects = current_user.projects
      project_pending = current_user.pending_projects
      @project_pending = project_pending.count

      project_processing = current_user.processing_projects
      @project_processing = project_processing.count

      project_completed = current_user.completed_projects
      @project_completed = project_completed.count

    end

  end

  def admin
    if admin?
      @projects = Project.get_all_projects
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
      redirect_to root_path, :notice => 'Project Created Successfully!'
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

    message_params = Hash.new
    message_params[:content] = 'Project Completed'
    message_params[:project_id] = params[:id]
    message_params[:user_id] = current_user.id

    message = Message.new message_params
    message.save

    project.update_attributes update_params
    redirect_to project_path
  end

  def show
    Time.zone = cookies[:bz_time_zone]
    @message = Message.new
    @project_id = params[:id]

    @project = Project.find(@project_id)
    @requirements = @project.requirements
    @project_status = @project.project_status
    @assets = @project.assets
    @deliverables = @project.deliverables

    @messages = Message.where(project_id: @project_id).order('created_at ASC')

    @messages.each do |message|
      message.read = true if params[:redirect] != 'yes' && message.user.id != current_user.id    #mark as read if the user has already read the message
      message.save
    end

    1.times { @deliverables.build unless @deliverables.present? }

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

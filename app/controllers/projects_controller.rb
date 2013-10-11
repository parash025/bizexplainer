class ProjectsController < ApplicationController

  before_action :require_login

	def index
		@projects = Project.all
	end


	def new
		@project = Project.new
	end

	def create
		@project = Project.new

		@project.title = params[:project][:title]
		@project.video_duration = params[:project][:video_duration]
		@project.voice_over = params[:project][:voice_over]
		@project.video_type = 'animated'
		@project.requirements = params[:project][:requirements]
		@project.project_status = 'pending'
		@project.payment_status = 'pending'
		@project.user_id = 1
		
		@project.save

		# parameters[:video_type]= 'animated'
		# parameters[:project_status]= 'pending'
		# parameters[:payment_status]= 'pending'
		# parameters[:user_id]= 1
		
		# Project.create(parameters) 

  end

  private

  def require_login
    redirect_to log_in_path unless session[:user_id]
  end

end

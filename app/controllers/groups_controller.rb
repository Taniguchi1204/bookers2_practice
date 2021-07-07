class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit,:update]


  def index
    @book = Book.new
    @groups = Group.all
  end

  def show
    @book = Book.new
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  def join
    @group = Group.find(params[:group_id])
    group = current_user.group_users.new(group_id: @group.id)
    group.save
    redirect_to  groups_path
  end

  def destroy
    @group = Group.find(params[:id])
    group_user = current_user.group_users.find_by(group_id: @group.id)
    group_user.destroy
    redirect_to groups_path
  end

  def new_mail
   @group = Group.find(params[:group_id])
  end

  def send_mail
   @group = Group.find(params[:group_id])
   group_users = @group.users
   @title = params[:title]
   @content = params[:content]
   ContactMailer.send_mail(group_users, @title, @content).deliver
  end

  private

  def group_params
    params.require(:group).permit(:group_name,:group_introduction,:image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.user_id == current_user.id
      redirect_to groups_path
    end
  end
end

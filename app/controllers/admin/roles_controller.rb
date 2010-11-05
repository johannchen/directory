class Admin::RolesController < ApplicationController
  # GET /admin/roles
  def index
    @roles = Role.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # GET /admin/roles/1
  def show
    @role = Role.find(params[:id])
    @users = @role.users

    @existing_users = User.where(["id not in (?)", @users.map(&:id)])
    @user = User.new

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /admin/roles/new
  def new
    @role = Role.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /admin/roles/1/edit
  def edit
    @role = Role.find(params[:id])
  end

  # POST /admin/roles
  def create
    @role = Role.new(params[:role])

    respond_to do |format|
      if @role.save
        format.html { redirect_to(@role, :notice => 'Role was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /admin/roles/1
  def update
    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to(@role, :notice => 'Role was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /admin/roles/1
  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(roles_url) }
    end
  end
end

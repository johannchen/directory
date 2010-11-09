class RolesController < ApplicationController
  # GET /roles
  def index
    @roles = Role.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # GET /roles/1
  def show
    @role = Role.find(params[:id])
    @users = @role.users

    @existing_users = User.where(["id not in (?)", @users.map(&:id)])
    @user = User.new

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /roles/new
  def new
    @role = Role.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /roles/1/edit
  def edit
    @role = Role.find(params[:id])
  end

  # POST /roles
  # POST /roles.xml
  def create
    @role = Role.new(params[:role])

    respond_to do |format|
      if @role.save
        format.html { redirect_to(@role, :notice => 'Role was successfully created.') }
        format.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to(@role, :notice => 'Role was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(roles_url) }
      format.xml  { head :ok }
    end
  end

  def assign
    # assign users to role
    @role = Role.find(params[:id])
    if params[:commit] == "Add"
      @role.user_ids += params[:assign_user_ids]
    elsif params[:commit] == "Remove"
      @role.user_ids -= params[:remove_user_ids].map(&:to_i)
    end
    
    redirect_to :action => :show
  end
end

class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.xml
  def index
    @contacts = Contact.all
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new
    # TODO: a list of users who are staff and helper belong the same group
    # TODO: what if admin modify the role. no role modification in admin page.
    # note: cannot use variable name helper
    @staff_users = Role.first.users.select("id, name").order(:name)
    @helper_users = Role.find(2).users.select("id, name").order(:name)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
    @active_lead_id ||= @contact.active_lead.id unless @contact.active_lead.nil?
    @active_helper_id ||= @contact.active_helper.id unless @contact.active_helper.nil?
    @staff_users = Role.first.users.select("id, name").order(:name)
    @helper_users = Role.find(2).users.select("id, name").order(:name)
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        # create relationships
        Relationship.create! :contact => @contact, :user => User.find(params[:leader]), :relationship => 'lead', :active => true
        Relationship.create! :contact => @contact, :user => User.find(params[:helper]), :relationship => 'helper', :active => true

        #link groups
        

        format.html { redirect_to(@contact, :notice => 'Contact was successfully created.') }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        Relationship.create! :contact => @contact, :user => User.find(params[:leader]), :relationship => 'lead', :active => true
        Relationship.create! :contact => @contact, :user => User.find(params[:helper]), :relationship => 'helper', :active => true
        format.html { redirect_to(@contact, :notice => 'Contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end
end

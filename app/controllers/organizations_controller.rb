class OrganizationsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @organization = current_user.organization
    if @organization.present?
      render :show
    else
      redirect_to organizations_path
    end
  end

  def new
    @organization = Organization.new
    @organization.build_address
    @organization.build_contact(email: current_user.email)
  end

  def edit
    @organization = current_user.organization
  end

  def create
    @organization = Organization.new
    @organization.update_attributes organization_params_for_create
    @organization.user = current_user

    if @organization.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def update
    @organization.update_attributes organization_params_for_create

    if @organization.save
      redirect_to root_path
    else 
      render :edit
    end
  end

  private

  def organization_params_for_create
    params.require(:organization).permit(
      :name,
      :vat_number,
      :tax_office,
      address_attributes: [ :street, :city, :region, :postal_code, :country_id],
      contact_attributes: [ :first_name, :last_name, :email])
  end
end

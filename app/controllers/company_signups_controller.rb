class CompanySignupsController < ApplicationController
  before_action :require_login

  def welcome
    @organization = current_user.organization
    
    if @organization.present?
      redirect_to company_signup_address_path if @organization.address.nil?
      redirect_to company_signup_contact_path if @organization.contact.nil?
    end
  end

  def business
    @organization = current_user.organization || Organization.new
  end

  def create_business
    @organization = current_user.organization || Organization.new(user: current_user)
    redirect_to company_signup_address_path if @organization.nil?

    @organization.update_attributes params_for_business
    if @organization.save
      redirect_to company_signup_address_path
    else
      render :business
    end
  end

  def address
    @organization = current_user.organization
    redirect_to company_signup_business_path if @organization.nil?
  end

  def create_address
    @organization = current_user.organization
    redirect_to company_signup_business_path if @organization.nil?

    if @organization.address.present?
      @organization.address.update_attributes(params_for_address)
    else
      @organization.address.build_address(params_for_address)
    end

    if @organization.address.save
      redirect_to company_signup_contact_path
    else
      render :address
    end
  end

  def contact
    @organization = current_user.organization
    redirect_to company_signup_contact_path if @organization.nil?
  end

  def create_contact
    @organization = current_user.organization
    redirect_to company_signup_business_path if @organization.nil?

    if @organization.contact.present?
      @organization.contact.update_attributes(params_for_contact)
    else
      @organization.contact.build_contact(params_for_contact)
    end

    if @organization.contact.save
      redirect_to root_path
    else
      render :contact
    end
  end

  private

  def params_for_business
    params.require(:organization).permit(:name, :vat_number, :tax_office, :size)
  end

  def params_for_address
    params.require(:address).permit(:street, :city, :region, :postal_code, :country_id)
  end

  def params_for_contact
    params.require(:contact).permit(:first_name, :last_name, :email)
  end

end

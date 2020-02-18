module PermissionsHelper

  def permissions
    search_filters_from_params.apply
  end

  def search_filters_from_params
    PermissionSearchFilters.new(filter_params)
  end

  def name_filter_value
    filter_params[:name]
  end

  def resource_filter_value
    filter_params[:resource]
  end
  
  def action_filter_value
    filter_params[:action]
  end

  def filter_params
    params[:filters] || {}
  end
end

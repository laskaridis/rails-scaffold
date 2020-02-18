class PermissionSearchFilters
  attr_reader :name
  attr_reader :resource
  attr_reader :action

  def initialize(opts = {})
    @name = opts[:name]
    @resource = opts[:resource]
    @action = opts[:action]
  end

  def present?
    (@name || @resource || @action).present?
  end

  def apply
    init_query
    apply_name_filter if name.present?
    apply_resource_filter if resource.present?
    apply_action_filter if action.present?
    execute_query
  end

  private

  def init_query
    @query = Permission
  end

  def apply_name_filter
      @query = @query.where("lower(name) like ?", "%#{name.downcase}%")
  end

  def apply_resource_filter
      @query = @query.where("lower(resource) like ?", "%#{resource.downcase}%")
  end

  def apply_action_filter
      @query = @query.where("lower(action) like ?", "%#{action.downcase}%")
  end

  def execute_query
    @query.all
  end
end

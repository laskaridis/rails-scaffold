module Authorization
  extend ActiveSupport::Concern

  def require_login
    unless logged_in?
      deny_access
    end
  end

  def deny_access(message = nil)
    respond_to do |format|
      format.any(:js, :json, :xml) { head :unauthorized }
      format.any { redirect_request(message) }
    end
  end

  protected

  def redirect_request(message)
    store_location

    if message
      flash[:error] = message
    end

    if logged_in?
      redirect_to root_url
    else
      redirect_to login_url
    end
  end

  def store_location
    if request.get?
      session[:return_to] = request.original_fullpath
    end
  end

  def redirect_back_or(default)
    redirect_to(return_to || default)
    clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil
  end

  def return_to
    if return_to_url
      uri = URI.parse(return_to_url)
      "#{uri.path}?#{uri.query}".chomp('?')
    end
  end

  def return_to_url
    session[:return_to]
  end
end

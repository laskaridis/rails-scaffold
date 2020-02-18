require "rails_helper"

describe PermissionsController do

  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/roles/1/permissions").to route_to(controller: "permissions",
                                                               action: "index",
                                                               role_id: "1")
    end

  end
end

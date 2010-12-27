Rails.application.routes.draw do

  scope "admin", :module => :admin, :as => "admin" do

    match "/" => redirect("/admin/dashboard")
    match "user_guide" => "base#user_guide"

    resource :dashboard, :only => [:show], :controller => :dashboard

    if Typus.authentication == :session
      resource :session, :only => [:new, :create, :destroy], :controller => :session
      resources :account, :only => [:new, :create, :show, :forgot_password] do
        collection { get :forgot_password }
      end
    end

    Typus.models.map { |i| i.to_resource }.each do |resource|
      match "#{resource}(/:action(/:id(.:format)))", :controller => resource
    end

  end

end

class BetaRedirectConstraint
  INIT_BETA_CODE = APP_CONFIG["init_beta_code"]
  BETA_CODE = APP_CONFIG["beta_code"]

  def matches?(request)
#    debugger
    cookies = request.cookie_jar
    params = request.query_parameters

    if params[:nobeta]
      cookies.delete :beta
      return true
    end

    if params[:beta] == INIT_BETA_CODE
      cookies.permanent.signed[:beta] = BETA_CODE
    elsif cookies.signed[:beta] != BETA_CODE
      return true
    end

    return false
  end
end
 
#TwitterClone::Application.routes.draw do
#  match "*path" => "blacklist#index",
#    :constraints => BlacklistConstraint.new
#end
#


Railscasts::Application.routes.draw do
  resources :emails

  root :to => redirect("/site-under-construction/index.html", :status => 307), :constraints => BetaRedirectConstraint.new
  match '*path' => redirect("/site-under-construction/index.html", :status => 307), :constraints => BetaRedirectConstraint.new

  root :to => "episodes#index"

  match "auth/:provider/callback" => "users#create"
  match "about" => "info#about", :as => "about"
  match "give_back" => "info#give_back", :as => "give_back"
  match "moderators" => "info#moderators", :as => "moderators"
  match "login" => "users#login", :as => "login"
  match "logout" => "users#logout", :as => "logout"
  match "feedback" => "feedback_messages#new", :as => "feedback"
  match "episodes/archive" => redirect("/?view=list")
  match 'unsubscribe/:token' => 'users#unsubscribe', :as => "unsubscribe"
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"

  resources :users do
    member { put :ban }
  end
  resources :comments
  resources :episodes
  resources :feedback_messages

  match "tags/:id" => redirect("/?tag_id=%{id}")
end

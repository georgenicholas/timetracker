class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present?
  end
end

class SubdomainBlank
  def self.matches?(request)
    request.subdomain.blank?
  end
end

Rails.application.routes.draw do
  constraints(SubdomainPresent) do
    root 'projects#index', as: :subdomain_root
    devise_for :users
    resources :users, only: :index
    resources :projects, except: [:show, :destroy]
  end
  constraints(SubdomainBlank) do
    root :to => 'welcome#index'
    resources :accounts, only: [:new, :create]
  end
end

Rails.application.routes.draw do

  resources :complaints
  devise_for :users, controllers: { registrations: 'registrations' } 
  # as :user do
  #   get 'users/sign_up', constraints: lambda { |request| request.subd) }
  #   end
  # end

  constraints SubDomainConstraint do
    root 'dashboard#index'

    resources :members do
      collection do
        get 'emergency_contacts'
      end
    end

  end

  constraints PublicDomainConstraint do
    get '/' => 'home#index'
  end

end

Rails.application.routes.draw do

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

    resources :complaints do
      member do
        put 'upvote'
      end
    end

    mount Commontator::Engine => '/commontator'
  end

  constraints PublicDomainConstraint do
    get '/' => 'home#index'
  end

end

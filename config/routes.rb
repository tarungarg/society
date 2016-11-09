Rails.application.routes.draw do

  resources :banners
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
        put 'mark_as_resolve'
        put 'mark_as_unresolve'
        post 'create_review'
      end
      collection do
        get 'mark_all_read'
      end
    end

    resources :announcements

    resources :policies do
      member do
        get 'download'
      end
    end

    mount Commontator::Engine => '/commontator'

  end

  constraints PublicDomainConstraint do
    get '/' => 'home#index'
  end

end

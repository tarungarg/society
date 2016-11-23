Rails.application.routes.draw do

  resources :clubs
  devise_for :users, controllers: { registrations: 'registrations',  :invitations => 'users/invitations' }

  constraints SubDomainConstraint do
    root 'dashboard#index'

    resources :members do
      collection do
        get 'emergency_contacts'
      end
      member do
        put 'update_candidate'
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

    resources :policies do
      member do
        get 'download'
      end
    end

    get 'votes/index'
    put 'votes/vote'
    get 'votes/detail'
    put 'votes/visible'
    get 'votes/declare'
    get 'charges/invite'
    get 'charges/invite_all'

    resources :announcements
    resources :banners
    resources :funds
    resources :trusts
    resources :charges
    resources :suggestions
    resources :jobs
    resources :subscriptions
    resources :products
    resources :rents
    resources :carpools

    mount Commontator::Engine => '/commontator'

  end

  constraints PublicDomainConstraint do
    get '/' => 'home#index'
  end

end

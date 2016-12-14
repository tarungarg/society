Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', invitations: 'users/invitations' }

  constraints SubDomainConstraint do
    root 'dashboard#index'

    resources :members do
      collection do
        get 'emergency_contacts'
      end
      member do
        put 'update_candidate'
        get 'user_profile'
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

    resources :public_complaints

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
    resources :clubs
    resources :elections
    resources :elections_participated_users
    get 'mailbox/inbox' => "mailbox#inbox", as: :mailbox_inbox
    get 'mailbox/sent' => "mailbox#sent", as: :mailbox_sent
    get 'mailbox/trash' => "mailbox#trash", as: :mailbox_trash
    resources :posts do
      member do
        get 'like'
        get 'unlike'
      end
    end
    resources :conversations do
      member do
        post :reply
        post :trash
        post :untrash
        post :restore
      end
    end
  
    mount ActionCable.server => '/cable'
    match '/websocket', to: ActionCable.server, via: %i(get post)
    mount Commontator::Engine => '/commontator'
    mount Ckeditor::Engine => '/ckeditor'
  end

  get '/' => 'home#index'

  constraints PublicDomainConstraint do
    get '/' => 'home#index'
  end
end

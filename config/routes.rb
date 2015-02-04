Rails.application.routes.draw do
  root to: 'projects#index'

  shallow do
    resources :projects do
      resources :issues, except: :index do
        resources :records, except: [:index, :show]

        member do
          patch :close
          patch :open
        end
      end
    end
  end
end

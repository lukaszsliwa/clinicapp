Clinicapp::Application.routes.draw do
  namespace :admin do
    resources :patients
    resources :trials
    resources :questions
  end

  namespace :public do
    resources :trials, :only => :index do
      resource :patient, :only => [:new, :create, :show], :controller => 'trials/patients' do
        resources :questions, :only => [:index, :update], :controller => 'trials/patients/questions'
      end
    end
  end

  match '/admin' => 'admin/patients#index'

  root :to => 'public/trials#index'
end

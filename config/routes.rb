Clinicapp::Application.routes.draw do
  resources :patients
  resources :trials
  resources :questions

  namespace :public do
    resources :trials, :only => :index do
      resource :patient, :only => [:new, :create, :show], :controller => 'trials/patients' do
        resources :questions, :only => [:index, :update], :controller => 'trials/patients/questions'
      end
    end
  end

  root :to => 'patients#index'
end

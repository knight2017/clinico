Rails.application.routes.draw do


  root "doctors#index"
  resources :sessions, only: [:new, :create] do
     delete :destroy, on: :collection
  end
  resources :comments
  resources :doctors do
    resources :availabilities, only: [:index, :create, :destroy]
    resources :approvals, only: [:create, :destroy]
  end
  resources :users do
    resources :appointments, only: [:create, :destroy]
  end
  get  '/display/:id'  => 'doctors#display', as: :display
  post '/login/doctor' => 'sessions#create_doctor', as: :doctor_login
  get 'users/:user_id/appointments/' => 'appointments#appointment_new', as: :appointment_new
  patch   "/appointments/:id/cancel" => "appointments#cancel"
  patch "/doctor/:doctor_id/approval/:id/approve" => 'approvals#approval_patient', as: :approval_patient
  patch "/doctor/:doctor_id/approval/:id/unapprove" => 'approvals#decline_patient',     as: :decline_patient
end

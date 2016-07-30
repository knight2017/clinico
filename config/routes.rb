Rails.application.routes.draw do

  resources :appointments
  root "doctors#index"
  resources :sessions, only: [:new, :create] do
     delete :destroy, on: :collection
  end
  resources :comments
  resources :doctors do
    resources :approvals, only: [:create, :destroy]
  end
  resources :users
  get  '/display/:id'  => 'doctors#display', as: :display
  post '/login/doctor' => 'sessions#create_doctor', as: :doctor_login

  patch "/doctor/:doctor_id/approval/:id/approve" => 'approvals#approval_patient', as: :approval_patient
  patch "/doctor/:doctor_id/approval/:id/unapprove" => 'approvals#decline_patient',     as: :decline_patient
end

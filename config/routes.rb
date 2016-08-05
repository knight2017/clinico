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
  get '/doctors/:doctor_id/availabilities/view' => 'availabilities#user_view_avail'
  get 'users/:user_id/appointments/' => 'appointments#appointment_new', as: :appointment_new
  patch   "/appointments/:id/cancel" => "appointments#cancel"
  patch "/doctor/:doctor_id/approval/:id/approve" => 'approvals#approval_patient', as: :approval_patient
  patch "/doctor/:doctor_id/approval/:id/unapprove" => 'approvals#decline_patient',     as: :decline_patient
  get 'users/:user_id/doctors/' => 'users#doctors'
  patch "users/:user_id/appointments/:id/confirm" => 'appointments#confirm'
  patch "users/:user_id/appointments/:id/reject" => 'appointments#reject'
  patch "users/:user_id/appointments/:id/miss" => 'appointments#miss'
  patch "users/:user_id/appointments/:id/attend" => 'appointments#attend'
  patch "doctors/:doctor_id/availabilities/:id/close" => 'availabilities#close'
  patch "doctors/:doctor_id/availabilities/:id/reopen" => 'availabilities#reopen'
  get '/doctors/:id/patients' => 'doctors#patients'
end

# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'campaigns#index'
  resources :campaigns, only: %i[index show]
end

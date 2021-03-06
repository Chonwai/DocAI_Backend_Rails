# == Route Map
#

Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations",
             }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, :defaults => { :format => :json } do
    namespace :v1 do
      # **********Documents API**********
      resource :documents do
        get ":id", to: "documents#show"
        # Show documents by tag id
        get "tags/:tag_id", to: "documents#show_by_tag"
        member do
          post ":id/approval", to: "documents#approval"
        end
        # Show and Predict the Latest Uploaded Document
        get "latest/predict", to: "documents#show_latest_predict"
      end

      # **********Search API**********
      # Search documents by name like name param
      get "search/documents/name", to: "documents#show_by_name"
      # Search documents by content like content param
      get "search/documents/content", to: "documents#show_by_content"
      # Search form data by form schema name and date
      get "search/form/:name/:date", to: "form_datum#show_by_form_name_and_date"
      # Search form data by date
      get "search/form/:date", to: "form_datum#show_by_date"

      # **********Tags API**********
      get "tags", to: "tags#index"
      get "tags/:id", to: "tags#show"
      get "tags/tagging/document", to: "tags#show_by_tagging"
      post "tags", to: "tags#create"
      put "tags/:id", to: "tags#update"

      # # **********Storage API**********
      post "storage/upload", to: "storage#upload"
      post "storage/upload/bulk/tag", to: "storage#upload_bulk_tag"

      # **********FormSchema API**********
      get "form/schemas", to: "form_schema#index"
      get "form/schemas/:id", to: "form_schema#show"
      get "form/schemas/name/:name", to: "form_schema#show_by_name"

      # **********FormDatum API**********
      get "form/datum", to: "form_datum#index"
      get "form/datum/:id", to: "form_datum#show"
      put "form/datum/:id", to: "form_datum#update"

      # **********AbsenceForm API**********
      get "form/absence/approval", to: "absence_forms#show_by_approval_status"
      get "form/absence/approval/:id", to: "absence_forms#show_by_approval_id"
      post "form/absence", to: "absence_forms#upload"
      put "form/absence/:id", to: "absence_forms#update"

      # **********Classification API**********
      get "classification/predict", to: "classifications#predict"
      post "classification/confirm", to: "classifications#confirm"

      # **********Statistics API**********
      get "statistics/count/tags/:date", to: "statistics#count_each_tags_by_date"
      get "statistics/count/documents/:date", to: "statistics#count_document_by_date"

      # **********Document Approval API**********
      get "approval/documents", to: "document_approvals#index"
      get "approval/documents/:id", to: "document_approvals#show"
      put "approval/documents/:id", to: "document_approvals#update"
    end
  end
end

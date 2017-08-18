Rails.application.routes.draw do

  resources :contactos

#  root "archivos#listar_archivos"
  root "contactos#index"

  get  "archivos/cargar_archivos"
  post "archivos/cargar_archivos"
  get  "archivos/listar_archivos"
  post "archivos/borrar_archivos"

end

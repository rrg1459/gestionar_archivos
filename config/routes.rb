Rails.application.routes.draw do

root "archivos#listar_archivos"

get  "archivos/subir_archivos"
post "archivos/subir_archivos"
get  "archivos/listar_archivos"
post "archivos/borrar_archivos"

end

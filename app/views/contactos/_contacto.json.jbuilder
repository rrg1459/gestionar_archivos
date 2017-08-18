json.extract! contacto, :id, :numero, :nombre, :created_at, :updated_at
json.url contacto_url(contacto, format: :json)

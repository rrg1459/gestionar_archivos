class AddArchivosToContactos < ActiveRecord::Migration[5.1]
  def change
    add_column :contactos, :archivos, :string
  end
end

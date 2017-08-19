class AddArchivoToContactos < ActiveRecord::Migration[5.1]
  def change
    add_column :contactos, :archivo, :string,  default: "en linea"
  end
end

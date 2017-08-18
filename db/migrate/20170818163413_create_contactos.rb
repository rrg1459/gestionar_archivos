class CreateContactos < ActiveRecord::Migration[5.1]
  def change
    create_table :contactos do |t|
      t.string :numero
      t.string :nombre

      t.timestamps
    end
  end
end

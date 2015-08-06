class CreateAlumnos < ActiveRecord::Migration
  def change
    create_table :alumnos do |t|
      t.string :nombre
      t.integer :curso_id
      t.string :numero

      t.timestamps null: false
    end
  end
end

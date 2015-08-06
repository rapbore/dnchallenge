class CreateColegios < ActiveRecord::Migration
  def change
    create_table :colegios do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end

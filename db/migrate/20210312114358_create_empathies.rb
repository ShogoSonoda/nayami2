class CreateEmpathies < ActiveRecord::Migration[6.1]
  def change
    create_table :empathies do |t|
      t.references :user, null: false
      t.references :post, null: false
      t.timestamps
    end
  end
end

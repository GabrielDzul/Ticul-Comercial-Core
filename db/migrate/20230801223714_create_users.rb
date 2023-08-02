class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :paternal_surname
      t.string :maternal_surname
      t.string :full_name
      t.string :email
      t.string :phone
      t.string :status
      t.boolean :verified
      t.boolean :blocked
      t.string :activation_code
      t.datetime :activation_date

      t.timestamps

      t.index :email, unique: true
      t.index :phone, unique: true
      t.index :activation_code, unique:true
    end

  end
end

class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :status
      t.decimal :balance, precision: 18, scale: 6
      t.belongs_to :user, type: :uuid

      t.timestamps
    end
  end
end

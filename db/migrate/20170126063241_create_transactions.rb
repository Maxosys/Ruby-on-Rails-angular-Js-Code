class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :username
      t.float :amount

      t.timestamps
    end
  end
end

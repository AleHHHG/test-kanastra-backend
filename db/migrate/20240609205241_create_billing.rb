class CreateBilling < ActiveRecord::Migration[7.1]
  def change
    create_table :billings do |t|
      t.string :name
      t.string :email
      t.string :document
      t.decimal :amount
      t.date :due_date
      t.string :uuid
      t.boolean :sent, default: false
    end
  end
end

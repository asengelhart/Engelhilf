class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.text :content
      t.datetime :closed_on
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

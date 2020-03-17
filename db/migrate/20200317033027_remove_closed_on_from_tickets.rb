class RemoveClosedOnFromTickets < ActiveRecord::Migration[6.0]
  def change
    remove_column :tickets, :closed_on
  end
end

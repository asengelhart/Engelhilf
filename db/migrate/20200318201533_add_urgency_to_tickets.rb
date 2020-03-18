class AddUrgencyToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :urgency, :integer
  end
end

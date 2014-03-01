class CreateBlockingClients < ActiveRecord::Migration
  def change
    create_table :blocking_clients, :id => false do |t|
    	t.primary_key :blocking_client_id
      t.integer :blocking_client_id
      t.string :car_number
      t.float :lat
      t.float :long

      t.timestamps
    end
    

  end
end

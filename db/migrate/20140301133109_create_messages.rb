class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages, :id => false do |t|
    	t.primary_key :message_id
      t.integer :message_id
      t.integer :blocking_client_id
      t.text :message_text
      t.boolean :unread

      t.timestamps
    end
    
  end
end

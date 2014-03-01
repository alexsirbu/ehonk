class Message < ActiveRecord::Base
  attr_accessible :blocking_client_id, :message_id, :message_text, :unread
  belongs_to :blocking_client
end

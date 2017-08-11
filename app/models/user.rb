class User < ApplicationRecord
  has_secure_password

  has_many :sent_messages, class_name: 'Message',
                  foreign_key: 'sender_id'

  has_many :received_messages, class_name: 'Message',
                      foreign_key: 'receiver_id'

  def full_name
    [self.first_name, self.last_name].join(' ')
  end

  def conversations
    messages = [self.sent_messages, self.received_messages].flatten
    users = messages.each_with_object([]) do |message, array|
      if self == message.sender
        array << message.receiver
      else
        array << message.sender
      end
    end
    users.sort_by(&:first_name).uniq
  end

  def self.search_with(regexp)
    users = self.pluck(:id, :first_name, :last_name)
    users.select do |a|
      "#{a.second} #{a.last}" =~ regexp
    end.each_with_object([]) do |obj, a|
      a << { id: obj.first, full_name: obj.second + " " + obj.last }
    end
  end
end

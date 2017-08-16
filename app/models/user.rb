class User < ApplicationRecord
  has_secure_password

  has_many :sent_messages, class_name:  'Message',
                           foreign_key: 'sender_id'

  has_many :received_messages, class_name:  'Message',
                               foreign_key: 'receiver_id'

  validates_presence_of :email, :password, :first_name, :last_name

  validates_uniqueness_of :email

  validates_format_of :email,
                      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def self.search_with(regexp)
    users = self.pluck(:id, :first_name, :last_name)
    users.select do |a|
      "#{a.second} #{a.last}" =~ regexp
    end.each_with_object([]) do |obj, a|
      a << { id: obj.first, full_name: obj.second + " " + obj.last }
    end
  end

  def full_name
    [self.first_name, self.last_name].join(' ')
  end

  def conversations
    messages = [self.sent_messages.includes(:sender, :receiver),
                self.received_messages.includes(:sender, :receiver)].flatten
    users = messages.each_with_object([]) do |message, array|
      if self == message.sender
        array << message.receiver
      else
        array << message.sender
      end
    end
    users.reverse.uniq
  end

  def messages_with(user)
    Message.where('receiver_id in (:s, :r) and sender_id in (:s, :r)',
      s: self.id, r: user.id)
  end
end

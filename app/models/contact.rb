class Contact < MailForm::Base
  attribute :name, validate: true
  attribute :email, validate: true
  attribute :message
  def headers
    {
      subject: 'Email from submission form',
      to: 'henryarvans@gmail.com',
      from: %("#{name}" <#{email}>)
    }
  end
end

class TestMailer < ApplicationMailer
  def hello_email
    mail(
      to: "teste@teste.com",
      subject: "Teste Mailpit",
      body: "Funcionou..."
    )
  end
end

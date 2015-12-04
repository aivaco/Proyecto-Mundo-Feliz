require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
=begin test "account_activation" do
    mail = UserMailer.account_activation
    assert_equal "Account activation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "password_reset" do
    mail = UserMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
=end  end
  
  test "account_activation" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Activación de cuenta", mail.subject
    assert_equal [user.usuario], mail.to #Entre los corchetes va user.email
    assert_equal ["noreply@mundofeliz.com"], mail.from
    assert_match user.usuario,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.usuario), mail.body.encoded #Entre los paréntesis va user.email
  end
  
    test "password_reset" do
    user = users(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Reinicio de contraseña", mail.subject
    assert_equal [user.usuario], mail.to
    assert_equal ["noreply@mundofeliz.com"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.usuario), mail.body.encoded
  end

end

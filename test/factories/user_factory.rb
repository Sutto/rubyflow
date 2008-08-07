Factory.define :user do |u|
  u.login { Factory.next :login }
  u.password 'sekrit'
  u.password_confirmation 'sekrit'
end
User.seed(:email) do |u|
  u.email = 'rosskaff@gmail.com'
  u.password = 'password'
  u.password_confirmation = 'password'
end

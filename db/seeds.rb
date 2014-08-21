User.find_by(email: 'rosskaff@gmail.com') || User.create(
  email: 'rosskaff@gmail.com', password: 'password', password_confirmation: 'password')

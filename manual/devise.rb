
user = User.new(email: 'admin@admin.admin')
user.password = '123456'
user.save

user.valid_password?('123456')
# => true

user.send_reset_password_instructions

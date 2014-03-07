# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

#RadSampleApp::Application.config.secret_key_base = '07567a4b612ea581fb11d677fb0e60400420d6f5006f30dafa7c5ccdbdfa95274b4ec6dd96b79c0e1420c1e24cf6ea27e7bb8acb7cdb906331eede369266be1c'
require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

RadSampleApp::Application.config.secret_key_base = secure_token
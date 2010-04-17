# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_CityEyes_session',
  :secret      => 'cd84d43e22ea546f54e8f1642c6a7797bc8e8d06d9a4d48c1ed06d6f3238a187ea532f2eae739c625c3e2f6f2c50450bfa5b10a05eb6b0f062540d42a0b72b37'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

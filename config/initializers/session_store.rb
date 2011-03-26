# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_projectcontrol_session',
  :secret      => 'a19e9610e4114faa425b9c846ffac3a1e6d706e42b0e3c5971fb628bd9600ae3945476232261a6a1abcb8da81087021158961d5f5c9a24ced1c9bb589ea734f03e76edc61ab45a42fc65d5cf076b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store

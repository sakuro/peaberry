require 'rack/mime'

# Let's remove TLD-ish extension(s)
Rack::Mime::MIME_TYPES.delete('.com')

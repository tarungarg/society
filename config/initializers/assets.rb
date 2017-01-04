# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( filterrific/filterrific-spinner.gif
                                                  commontator/upvote_disabled.png
                                                  commontator/upvote_hover.png
                                                  commontator/upvote.png
                                                  commontator/upvote_active.png
                                                  commontator/downvote_hover.png
                                                  commontator/downvote.png
                                                  commontator/downvote_disabled.png
                                                  commontator/downvote_active.png
                                                  ckeditor/*
                                                  vendor.css
                                                  vendor.js
                                                  login.css
                                                  homepage.css
                                                  homepage.js)

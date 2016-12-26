# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_society_session', domain: '.lvh.me'

Rails.application.config.session_store :cookie_store, key: '_society_session',
                                                      domain: {
                                                        production: '.ucs-intrl.com',
                                                        development: '.lvh.me'
                                                      }.fetch(Rails.env.to_sym, :all)

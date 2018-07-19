use Mix.Config


config :bandwidth_api, application_id: {:system, "BANDWIDTH_APP_ID"},
                       user_id: {:system, "BANDWIDTH_USER_ID"},
                       api_token: {:system, "BANDWIDTH_API_TOKEN"},
                       api_secret: {:system, "BANDWIDTH_API_SECRET"},
                       account_id: {:system, "BANDWIDTH_ACCOUNT_ID"},
                       username: {:system, "BANDWIDTH_USERNAME"},
                       password: {:system, "BANDWIDTH_PASSWORD"},
                       site_id: {:system, "BANDWIDTH_SITE_ID"}
module PocketHotline
  class Application < Rails::Application

    # === REQUIRED CONFIG ===
    config.x.hotline.name = 'Rails Hotline'
    config.x.hotline.domain = 'railshotline.herokuapp.com'
    config.x.hotline.organizer = 'Chap Ambrose'
    # Operators and supporters will see this email
    config.x.hotline.organizer_email = 'chapambrose@gmail.com'
    # Numbers can be purchased from twilio.com
    config.x.hotline.number = '+18778174190'
    # sensetive config options need to be set as environment variables
    # learn more https://devcenter.heroku.com/articles/config-vars
    config.x.twilio.account_sid = 'ACd518ffb7e34c324fca7d16e48fb65fc5'
    config.x.twilio.auth_token = ENV['TWILIO_AUTH_TOKEN']


    # === OPTIONAL CONFIG ===
    # Forward all unanswered calls to another phone number
    # config.x.hotline.no_answer_forwarding_number = '+10000000000'
    # 
    # Text callers after they hang up and ask them for a review.
    # This number must be purchased via Twilio and can't be toll-free
    config.x.hotline.sms_number = '+15125492916'

    # Messages
    # Control what a caller hears when connecting to your hotline
    # If any operators are on call, this will be heard:
    # config.x.messages.welcome_text = 'Thanks for calling, please hold while connect you to an operator.'
    # Instead of the text-to-voice robot above, play an .mp3 or .wave file:
    config.x.messages.welcome_audio_file = 'http://pockethotline.production.s3.amazonaws.com/account/8/welcome_message/welcome.mp3'
    # 
    # If no operators are available or those available fail to pickup, this is heard:
    # config.x.messages.unavailable_text = "No one is available to take your call. Try again later."
    # Instead of the text-to-voice robot above, play an .mp3 or .wave file:
    config.x.messages.unavailable_audio_file = 'http://pockethotline.production.s3.amazonaws.com/account/8/unavailable_message/unavailable.mp3'

    # customize /widget.js text
    config.x.widget.headline = 'Questions about Ruby on Rails? Get free help'
    config.x.widget.operator_term = 'developer' # could be volunteers, experts, programers, etc...

    # Twitter
    # Automatically tweet when someone goes on call:
    # Create an application on twitter and get the necessary tokens
    # https://dev.twitter.com/docs/auth/tokens-devtwittercom
    # Make sure your Application Type is set to Read and Write
    config.x.twitter.consumer_key = '5gAjlzLsK7Bn7INLmeXA'
    config.x.twitter.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    config.x.twitter.screen_name = 'railshotline'
    config.x.twitter.access_token = ENV['TWITTER_ACCESS_TOKEN']
    config.x.twitter.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    config.x.twitter.tweets = [
        "A generous operator is standing by to take your question.",
        "We're available to talk now",
        "Knowledgable operators are waiting to answer your questions, give 'em a ring.",
        "Get it while it's hot, free advice.",
        "Got questions? Call and talk to a real person.",
        "An operator is available to answer your questions now.",
        "Stuck? Call and talk through your problem.",
        "Join us and share some of your knowledge"
    ]

    # Sponsorship
    # If you'd like to allow callers and the general public to "donate" money to the hotline,
    # you'll need to have an active stripe.com account which will be used to process the cards.
    config.x.stripe.secret_key = ENV['STRIPE_SECRET_KEY']
    config.x.stripe.publishable_key = 'pk_sDCQCpqmfVV1EtxeQQEBs3Ex8qQcx'
    # 
    # Additionaly, you may allow sponsors to upload an image to accompany their message.
    # This requires an Amazon Web Services S3 account:
    config.x.s3.bucket = 'pockethotline.production'
    config.x.s3.access_key_id = ENV['S3_ACCESS_KEY_ID']
    config.x.s3.secret_access_key = ENV['S3_SECRET_ACCESS_KEY']
  end
end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end
OmniAuth.config.test_mode = true if Rails.env.test?
OmniAuth.config.mock_auth[:twitter] = {
  :provider => 'twitter',
  :uid => '123545',

  # etc.
  :info => {
    :nickname => "thisduck", 
    :name=>"Adnan Ali", 
    :location=>"Toronto-ish", 
    :image=>"http://a0.twimg.com/profile_images/210556408/37108292_N04_normal.jpg", 
    :description=>"I'm just a guy who does some things and then stuff happens.", 
    :urls=>{
      :Website=>"http://www.jaaduhai.com/blog/", 
      :Twitter=>"http://twitter.com/thisduck"
    }
  }
}


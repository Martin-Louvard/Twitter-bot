require 'twitter'
require 'dotenv'# Appelle la gem Dotenv
require 'pry'

while true
    

        Dotenv.load('.env') # Ceci appelle le fichier .env (situé dans le même dossier que celui d'où tu exécute app.rb)
        # et grâce à la gem Dotenv, on importe toutes les données enregistrées dans un hash ENV

            # quelques lignes qui appellent les clés d'API de ton fichier .env
            
            config = { 
                consumer_key:        ENV["TWITTER_CONSUMER_KEY"],
                consumer_secret:     ENV["TWITTER_CONSUMER_SECRET"],
                access_token:       ENV["TWITTER_ACCESS_TOKEN"],
                access_token_secret: ENV["TWITTER_ACCESS_TOKEN_SECRET"] } 

                rClient = Twitter::REST::Client.new config
                sClient = Twitter::Streaming::Client.new(config)
            
        
            topics = ["#bonjour_monde"]
            sClient.filter(:track => topics.join(",")) do |object|
                if object.is_a?(Twitter::Tweet)
                    puts object.text
                    puts object.user
                    rClient.fav object 
                    rClient.follow object.user  
                end
            end


    
end
        
    
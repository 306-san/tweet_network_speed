require 'bundler'
require 'twitter'
require "csv"

# Twitterの設定。各自やってくれ
client = Twitter::REST::Client.new do |config|
    config.consumer_key = "xxx"
    config.consumer_secret = "xxx"
    config.access_token        = "xxx"
    config.access_token_secret = "xxxx"
end

low_speed_flag = false
high_speed_count = 5
low_speed_count = 5

loop do
    time = Time.now
    hoge = %x(speedtest-cli --server 13641 --simple --no-upload) #サーバーは各自指定して
    l = hoge.split()
    if l.length == 9
        speed = l[4]
        CSV.open('./speed_test.csv','a') do |test|
            test << [time.strftime('%F %T'),"#{speed}"]
        end
        if speed.to_i > 30 && ( high_speed_count < 3 || low_speed_count == 5 )
            p "high"
            tweet_text = "#{time}時点でのPingは#{l[1]+l[2]}で、速度は、#{l[3]+l[4]+l[5]}です"
            high_speed_count += 1
            low_speed_count = 0
        elsif speed.to_i <= 30 && low_speed_count < 3 || speed.to_i < 1
            p "low"
            tweet_text = "#{time}時点でのPingは#{l[1]+l[2]}で、速度は、#{l[3]+l[4]+l[5]}です"
            high_speed_count = 0
            low_speed_count += 1
        elsif high_speed_count == 4
            p "end_tweet_high"
            tweet_text = "人権が回復したようなのでアピールやめます。"
            high_speed_count += 1
        elsif low_speed_count == 4
            p "end_tweet_low"
            tweet_text = "当分人権がなさそうなのでツイートをやめます。"
            low_speed_count += 1
        else
            p "not_tweet"
            tweet_text = nil
        end

        client.update(tweet_text) if tweet_text != nil
    end
    sleep(300)
end

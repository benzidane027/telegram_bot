require 'telegram/bot'
require 'dotenv/load'
require 'base64'
require_relative './const'
require_relative './utils'

class Bot
  def initialize
    @bot = Telegram::Bot::Client.new(ENV['TELEGRAME_TOKEN'])
  end

  def run_telegram_bot
    @bot.run do |bot|
      bot.listen do |message|
        case message.to_s
        when '/start'
          @bot.api.send_message(chat_id: message.from.id, text: 'welcom in bot')
        when '/help'
          @bot.api.send_message(chat_id: message.from.id, text: '/download example.video.mp4')
        when '/d'
          video_path = 'https://videos.pexels.com/video-files/6000210/6000210-uhd_1440_2560_24fps.mp4'
          video_stream = StringIO.new(Base64.encode64(URI.open(video_path).read))

          @bot.api.send_video(chat_id: message.from.id, video: Faraday::FilePart.new(video_stream, 'video/mp4'))
        else
          @bot.api.send_message(chat_id: message.from.id, text: 'command not found')

        end
      end
    end
  end
end

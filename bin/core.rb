require 'telegram/bot'
require 'dotenv/load'
require 'tempfile'
require_relative './const'
require_relative './utils'

class Bot
  def initialize
    @bot = Telegram::Bot::Client.new(ENV['TELEGRAME_TOKEN'])
  end

  def run_telegram_bot
    @bot.run do |bot|
      bot.listen do |message|
        case message.to_s.split.first
        when '/start'
          @bot.api.send_message(chat_id: message.from.id, text: 'welcom in bot')
        when '/help'
          @bot.api.send_message(chat_id: message.from.id, text: '/d example.video.mp4')
        when '/d'
          begin
            video_url = message.to_s.split.last
            Tempfile.open(['downloaded_file', '.mp4']) do |temp_file|
              @bot.api.send_message(chat_id: message.from.id, text: 'download in server ..')
              video = URI.open(video_url)
              @bot.api.send_message(chat_id: message.from.id, text: 'sending to client ..')
              temp_file.binmode
              temp_file.write(video.read)
              temp_file.rewind
              @bot.api.send_video(chat_id: message.from.id, video: Faraday::UploadIO.new(temp_file, 'video/mp4'))
            end
          rescue StandardError
            @bot.api.send_message(chat_id: message.from.id, text: 'invalid input . try again')
          end

        else
          @bot.api.send_message(chat_id: message.from.id, text: 'command not found')

        end
      end
    end
  end
end

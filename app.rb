require 'open-weather-ruby-client'

class Connection
  attr_reader :client

  def initialize
    @client = OpenWeather::Client.new(api_key: 'bd5e378503939ddaee76f12ad7a97608')
  end 
end

class Weather
  attr_reader :data

  def initialize(client)
    @client = client
  end

  def data(city)
    @data = @client.current_weather(city: city, units: 'metric', lang: 'ru')
  end
end

class Screen
  def self.clear
    print "\e[H\e[2J"
  end
end

connection = Connection.new

weather = Weather.new(connection.client)

loop do 
  Screen.clear
  puts "1. Узнать погоду в городе"
  puts "2. Выйти"
  print "Ввод: "
  input = gets.to_i

  case input
  when 1
    loop do
      Screen.clear

      puts "Напишите название города или 0 чтобы выйти"
      input = gets.chomp.downcase.capitalize

      case input
      when "0"
        break
      else
        Screen.clear

        weather.data(input)
        data = weather.data

        puts "Погода в #{data.name}: #{data.main.temp}°C, #{data.weather.first.description}"
        print "Нажмите любую клавишу чтобы продолжить..."
        gets
      end
    end
  when 2
    exit
  else
    Screen.clear
    puts "Неверный ввод!"
    sleep(2)
  end
end


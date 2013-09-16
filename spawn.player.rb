# this will also be deleted before launch
# (it will be auto-generated when creating a new battle)
# Strategy Developers shouldn't have access to this code
# if you need to make changes:
# be sure to update both this file and its source in the kablamo repo
# source can be found at:
# https://github.com/carbonfive/kablammo/tree/master/app/assets/process/spawn.player.rb

def usage
  puts "Usage: ruby index.rb <channel> <strategy>"
  exit 1
end

usage if ARGV.empty?
username = ARGV[0]

require 'rubygems'
require 'bundler'
Bundler.require 'default'

require './lib/index'

require './player.rb'

strategy = Player.load_strategy username

raise "Player.load_strategy must return a Strategy not a #{strategy.class.name}!" unless strategy.kind_of? Strategy::Base

def next_turn(strategy, args)
  battle = Strategy::Model::Battle.new args
  strategy.execute_turn battle
end

def shutdown(process, msg=nil)
  puts "\n\n#{msg}" if msg
  exit 0
end

capsule = RedisMessageCapsule.capsule
send_channel = capsule.channel "#{username}-send"
receive_channel = capsule.channel "#{username}-receive"

send_channel.clear
Thread.abort_on_exception = true

process = Thread.current

receive_channel.register do |msg|
  if 'ready?'.eql? msg
    puts 'Battle is on!'
    send_channel.send :ready
  elsif 'loser'.eql? msg
    shutdown process, "#{username} you lost."
  elsif 'winner'.eql? msg
    shutdown process, "#{username} you won! Of Course."
  elsif 'shutdown'.eql? msg
    shutdown process
  else
    print '.'
    turn = next_turn strategy, msg
    send_channel.send turn
  end
end

puts "Welcome to Kablammo, #{username}!"

begin
  sleep
rescue SignalException => e
  puts
  puts 'You Quit'
end
puts "Game Over"

# frozen_string_literal: true

require_relative 'lib/table'
require_relative 'lib/codebreaker'
require_relative 'lib/codemaker'
require 'colorize'
require 'colorized_string'
include Show

table = [
  [['?', '?', '?', '?'], ['.', '.', '.', '.']],
  [['.', '.', '.', '.'], ['.', '.', '.', '.']],
  [['.', '.', '.', '.'], ['.', '.', '.', '.']],
  [['.', '.', '.', '.'], ['.', '.', '.', '.']],
  [['.', '.', '.', '.'], ['.', '.', '.', '.']],
  [['.', '.', '.', '.'], ['.', '.', '.', '.']],
  [['.', '.', '.', '.'], ['.', '.', '.', '.']],
  [['.', '.', '.', '.'], ['.', '.', '.', '.']],
  [['.', '.', '.', '.'], ['.', '.', '.', '.']],
  [['.', '.', '.', '.'], ['.', '.', '.', '.']],
  [['.', '.', '.', '.'], ['.', '.', '.', '.']],
  [['red', 'blue', 'green'], ['.', '.', '.', '.']],
  [['yellow', 'black', 'magenta'], ['.', '.', '.', '.']]
]

PrintTable(table)

def main(table)
  puts 'WELCOME TO MASTERMIND!!!'
  print 'Do you want to play as the codebreaker or the codemaker?: '
  play_as = gets.chomp
  if play_as == 'codemaker'
    codemaker = CodeMaker.new
    code = codemaker.make_code
    table.reverse_each.with_index do |round, indx|
      next if round[0][0] != '.'

      if indx == 2
        codemaker.print_available_colors
        guess = codemaker.pc_guess(round, true)
      else
        puts "Previous guess was #{table[(table.length - indx)][0]} and the clues are #{table[(table.length - indx)][1]}"
        codemaker.print_available_colors
        guess = codemaker.pc_guess(table[(table.length - indx)], false)
      end
      if guess['col'] == code['col']
        puts 'The computer has won!!'
        break
      else
        print 'The PC has guessed as follows: '
        guess['col'].each_with_index do |color, index|
          if index == guess['col'].length - 1
            print "and #{color}"
          else
            print "#{color}, "
          end
        end
        puts
        clues = codemaker.clues(code['col'])
        for i in 0..3
          round[0][i] = guess['col'][i]
          round[1][i] = clues[i]
          codemaker.delete_color(guess['col'][i]) if clues[i] == '.'
        end
        PrintTable(table)
      end
    end
    puts 'The PC lost!'
  else
    codebreaker = CodeBreaker.new
    code = codebreaker.make_code
    table.reverse_each do |round|
      next if round[0][0] != '.'

      guess = codebreaker.guess
      if guess['col'] == code['col']
        puts 'You have won!!'
        break
      else
        clues = codebreaker.clues(guess['col'], code['col'])
        for i in 0..3
          round[0][i] = guess['col'][i]
          round[1][i] = clues[i]
        end
        PrintTable(table)
      end
    end
    code['col'].each_with_index do |color, index|
      table[0][0][index] = color
    end
    puts 'You lost! :('
    PrintTable(table)
  end
end

main(table)

require 'colorize'

class CodeBreaker
  @@num_to_color = { 1 => 'red', 2 => 'blue', 3 => 'green',
                     4 => 'yellow', 5 => 'black', 6 => 'magenta' }
  @@color_to_num = { 'red' => 1, 'blue' => 2, 'green' => 3,
                     'yellow' => 4, 'black' => 5, 'magenta' => 6 }

  def initiliaze
    puts 'You have chosen to play as the Code Breaker'
  end

  def make_code
    num = []
    col = []
    for i in 0..3
      col[i] = @@num_to_color[rand(1..6)]
      num[i] = @@color_to_num[col[i]]
    end
    { 'num' => num, 'col' => col }
  end

  def clues(guess, code)
    clues = []
    rindexes = []
    code.each_with_index do |col, ind|
      if col == guess[ind]
        clues << 'red'
        rindexes << ind
      end
    end
    rindexes.reverse.each do |ind|
      code.delete_at(ind)
    end
    guess.each do |col|
      windexes = []
      counter = 0
      if code.include?(col)
        code.each_with_index do |ccol, cind|
          if col == ccol
            counter += 1
            windexes << cind
          end
        end
        counter.times do
          clues << 'white'
        end
        windexes.reverse.each do |wind|
          code.delete_at(wind)
        end
      end
    end
    if clues.length < 4
      n = 4 - clues.length
      n.times do
        clues << '.'
      end
    end
    clues
  end

  def guess
    # make logic to give a guess
    puts "Enter your guess e.g 'red blue yellow green'"
    print "What's your guess: "
    raw_guess = gets.chomp
    raw_guess = raw_guess.split(' ') # raw_guess == col
    num = []
    for i in 0..3
      num[i] = @@color_to_num[raw_guess[i]]
    end
    { 'num' => num, 'col' => raw_guess }
  end
end

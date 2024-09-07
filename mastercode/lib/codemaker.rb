class CodeMaker
  @@num_to_color = { 1 => 'red', 2 => 'blue', 3 => 'green',
                     4 => 'yellow', 5 => 'black', 6 => 'magenta' }
  @@color_to_num = { 'red' => 1, 'blue' => 2, 'green' => 3,
                     'yellow' => 4, 'black' => 5, 'magenta' => 6 }

  @@available_colors = ['red', 'blue', 'green', 'yellow', 'black', 'magenta'] # rubocop:disable Style/WordArray

  def initiliaze
    puts 'You have chosen to play as the Code Maker'
  end

  def delete_color(color)
    @@available_colors.delete(color)
  end

  def print_available_colors
    puts @@available_colors
  end

  def make_code
    puts 'Choose 4 colors among: red, blue, green, yellow, black, magenta'
    print 'Enter the code here: '
    raw_col = gets.chomp
    col = raw_col.split(' ')
    num = []
    for i in 0..3
      num[i] = @@color_to_num[col[i]]
    end
    { 'num' => num, 'col' => col }
  end

  def clues(code)
    print 'Remember the code is: '
    code.each_with_index do |color, index|
      if index == code.length - 1
        print "and #{color}"
      else
        print "#{color}, "
      end
    end
    puts ''
    print 'Enter your clues here: '
    clues = gets.chomp
    clues.split(' ')
  end

  def pc_guess(prev_round, first)
    num = []
    col = []
    if first
      puts 'this is the first round'
      for i in 0..3 # rubocop:disable Style/For
        col[i] = @@num_to_color[rand(1..6)]
        num[i] = @@color_to_num[col[i]]
      end
    else
      puts 'this is beyond first round'
      prev_guess = prev_round[0]
      clues = prev_round[1]

      clues.each_with_index do |clue, index|
        col[index] = if clue == 'red'
                       prev_guess[index]
                     else
                       @@available_colors[rand(0..@@available_colors.length - 1)]
                     end
      end
    end
    for i in 0..3 # rubocop:disable Style/For
      num[i] = @@color_to_num[col[i]]
    end
    { 'num' => num, 'col' => col }
  end
end

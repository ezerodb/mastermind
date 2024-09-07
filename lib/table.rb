require 'colorize'

module Show
  def PrintTable(table)
    puts ''
    table.each_with_index do |row, row_index|
      row.each_with_index do |side, side_index|
        side.each do |dot|
          if (row_index == 0 && side_index == 1) || (row_index == 11 && side_index == 1) || (row_index == 12 && side_index == 1)
            next
          end

          if side_index == 0
            if dot != '.' && dot != '?'
              print '  o  '.colorize(dot.to_sym)
            else
              print "  #{dot}  "
            end
          elsif dot != '.'
            print ' o '.colorize(dot.to_sym)
          else
            print " #{dot} "
          end
          print '|'
        end
        if side_index == 1
          puts ''
        else
          print '|'
        end
      end
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' if [0, 10].include?(row_index)
    end
  end
end

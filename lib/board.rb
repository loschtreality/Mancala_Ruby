require 'byebug'

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1, @name2 = name1, name2
    @cups = Array.new(14) { Array.new }
    place_stones
  end

  def place_stones
    stones = [:stone, :stone, :stone, :stone]
    @cups.each_with_index do |cup,idx|
      unless (idx == 6 || idx == 13)
        cup.concat(stones)
      end
    end
  end

  def valid_move?(start_pos)
    if (start_pos > 12 || start_pos < 1)
      raise "Invalid starting cup"
    elsif (start_pos == 6 || start_pos == 12)
      raise "Invalid starting cup"
    end
    true
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos].dup
    @cups[start_pos] = []
    index = start_pos + 1
    until stones.empty?
    index -= 13 if index > 13
    index += 1 if (current_player_name == @name1 && index == 13 || current_player_name == @name2 && index == 6)

      @cups[index]. << stones.pop
      index += 1
    end
  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def cups_empty?
  end

  def winner
  end
end

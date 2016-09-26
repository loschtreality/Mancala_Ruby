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
    stones = @cups[start_pos]
    @cups[start_pos] = []
    index = start_pos
    until stones.empty?
      index += 1
      index = 0 if index > 13

      if index == 6
        @cups[6] << stones.pop if current_player_name == @name1
      elsif index == 13
        @cups[13] << stones.pop if current_player_name == @name2
      else
        @cups[index] << stones.pop
      end

    end
    render
    next_turn(index)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
    if (ending_cup_idx == 13) || (ending_cup_idx == 6)
    :prompt
    elsif @cups[ending_cup_idx].count == 1
      :switch
    else
    ending_cup_idx
    end
  end

  def render
    # print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    # puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    # print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    # puts ""
    # puts ""
  end

  def cups_empty?
    side1 = false
    side2 = false
    @cups[0...6].each do |el|
      side1 = true if el.empty?
    end

    @cups[7...13].each do |el|
      side2 = true if el.empty?
    end

    side1 || side2
  end

  def winner
    prc = Proc.new {|a,b| a <=> b}
    p1_score = @cups[6].count
    p2_score = @cups[13].count

    case prc.call(p1_score,p2_score)
    when -1
      @name2
    when 0
      :draw
    when 1
      @name1
    end
  end
end

module Aggressive

  def move_to_center
    x, y = robot.x, robot.y
    target_x = (@battle.board.width - 1)/2 
    target_y = (@battle.board.height - 1)/2

    moves = []
    moves << case (target_y <=> y)
             when -1
               SOUTH
             when 1
               NORTH
             else
               nil
             end
    moves << case (target_x <=> x)
             when 1
               EAST
             when -1
               WEST
             else
               nil
             end
    moves.compact!
    if moves.length > 0
      moves.reverse if rand() < 0.5
      puts "MOVE #{moves.first}"
      return move moves.first
    end
    nil
  end

  def hunt
    x, y = robot.x, robot.y
    return first_possible_move 'nesw' if x == 0
    return first_possible_move 'eswn' if y == @battle.board.height - 1
    return first_possible_move 'swne' if x == @battle.board.width - 1
    return first_possible_move 'wnes' if y == 0
    first_possible_move 'wsen'
  end

  def fire_at!(enemy, compensate = 0)
    direction = robot.direction_to(enemy).round
    skew = direction - robot.rotation
    distance = robot.distance_to(enemy)
    max_distance = Math.sqrt(board.height * board.height + board.width * board.width)
    compensation = ( 10 - ( (10 - 3) * (distance / max_distance) ) ).round
    compensation *= -1 if rand(0..1) == 0
    skew += compensation if compensate > rand
    fire! skew
  end

  def act_aggressively
    #power_up = power_ups.first
    #puts "move_towards! (power_up)" if power_up
    #return move_towards! power_up if power_up

    enemy = opponents.first
    return rest if my.ammo == 0

    if enemy
      if !(aiming_at? enemy)
        return aim_at! enemy
      end
      if can_fire_at? enemy
        return fire_at! enemy
      end
    end
    puts 'no enemy to be seen'
    return rest unless robot.ammo > 0
    if move_to_center
      puts "move to center"
    else
      hunt
    end
  end
end

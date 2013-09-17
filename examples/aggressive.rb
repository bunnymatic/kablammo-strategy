module Aggressive

  def move_to_center
    x, y = robot.x, robot.y
    target_x = @battle.board.height - 1
    target_y = @battle.board.width - 1

    moves = ''
    moves << case (target_y <=> y)
             when -1
               "s"
             when 1
               "n"
             else
               nil
             end
    moves << case (target_x <=> x)
             when -1
               "w"
             when 1
               "e"
             else
               nil
             end
    if moves.compact.present?
      first_possible_move moves
    else
      nil
    end
  end

  def hunt
    puts 'hunting'
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
    hunt unless move_to_center
  end
end

module Aggressive

  def move_to_center
    x, y = robot.x, robot.y
    ew = ((@battle.board.width - 1)/2 - x).to_i
    ns = ((@battle.board.height - 1)/2 - y).to_i

    movements = []
    movements << ((ew < 0) ? 'w' : 'e') unless ew == 0
    movements << ((ns < 0) ? 'n' : 's') unless ns == 0
    if movements.length > 0
      movements.reverse! if rand() < 0.5
      return first_possible_move movements.join
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
    begin
      if enemy
        if !(aiming_at? enemy)
          return aim_at! enemy
        end
        if can_fire_at? enemy
          return fire_at! enemy
        end
      end
      return rest unless robot.ammo > 0
      r = move_to_center
      return r || hunt
    rescue
      hunt
    end
  end
end

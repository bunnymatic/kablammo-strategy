# How to Play

### 1. Fork the Kablammo Strategy Repo
[https://github.com/carbonfive/kablammo-strategy/fork](https://github.com/carbonfive/kablammo-strategy/fork)

### 2. Write Your Strategy 
(See below.)

### 3. Upload Your Robot
[http://kablammo.io/strategies/new](http://kablammo.io/strategies/new)

### 4. Fight!
[http://kablammo.io/battles/new](http://kablammo.io/battles/new)

- - -

## Writing Your Strategy

Your robot's strategy should be contained in the `strategy/strategy.rb` file located in your fork of the Kablammo Strategy repo.

Your strategy must implement a single method called `next_turn`. This method has access to the current battle including the game board with all robots and walls. The method must return one of four commands (strings):

* Rotate your turret: `r180`
* Fire your laser with optional compensation factor: `f10`
* Move in a cardinal direction: `n`
* Rest to regain ammo: `.`

Each robot begins with 5 ammo and 10 armor. If your robot's armor reaches 0, you are eliminated from the arena and lose 2 points. If your robot is the last remaining robot in the arena, you are victorious and gain 2 points.

All battles last (at most) 100 turns. If more than one robot remains after 100 turns (or if the remaining robots are eliminated simultaneously), each remaining robot earns 1 point for a tie.

All robot turns are resolved in phases, simultaneously:

* First all movement is resolved
* Then all firing is resolved
* Finally all damage is resolved
* Robots are then removed from the board as necessary

Because all movement is resolved before firing, your firing solution can be adjusted by up to 10 degrees in either direction from your turret's current facing. In this manner, your robot can 'guess' which direction the enemy robot is going to move and fire at the predicted location.

## Tips

To help you get started, there are sample strategies provided for agressive, defensive, and hybrid robots. 

In addition, `base.rb` contains a DSL that implements some of the more complicated logic for locating enemies, avoiding walls, and calculating firing solutions. The sample strategies utilize this DSL, but you are free to roll your own, so long as it emits one of the approved returns for the `next_turn` method.

## The Tournament

We'll be running a tournament pitting robots against each other throughout GoGaRuCo. To check your robot's standing, [visit the leaderboard](http://kablammo.io/strategies). 

Once the conference is over, we'll be selecting the "best" robot and award its creator a Printrbot Simple. This will probably be the robot with the best overall record, unless you cheat, in which case we will make your robot sadder than C3PO on Bespin.

Please [check out the rules](http://kablammo.io/rules) for details.

## Questions

If you have any questions, please email [kablammo@carbonfive.com](mailto:kablammo@carbonfive.com), come by the Carbon Five table at GoGaRuCo, or Tweet #kablammo and we'll try and give you a hand.
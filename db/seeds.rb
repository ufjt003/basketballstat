Team.delete_all
Game.delete_all
Player.delete_all

western_all_star_team = Team.create(name: '2014 Western All Star')
western_all_star_team.add_player(Player.create(name: 'Kevin Durant', number: 35))
western_all_star_team.add_player(Player.create(name: 'Blake Griffin', number: 32))
western_all_star_team.add_player(Player.create(name: 'Kevin Love', number: 42))
western_all_star_team.add_player(Player.create(name: 'Dirk Nowitzki', number: 41))
western_all_star_team.add_player(Player.create(name: 'Kobe Bryant', number: 24))
western_all_star_team.add_player(Player.create(name: 'Stephen Curry', number: 30))
western_all_star_team.add_player(Player.create(name: 'Chris Paul', number: 3))
western_all_star_team.add_player(Player.create(name: 'Tony Parker', number: 9))
western_all_star_team.add_player(Player.create(name: 'Dwight Howard', number: 12))
western_all_star_team.add_player(Player.create(name: 'James Harden', number: 13))

eastern_all_star_team = Team.create(name: '2014 Eastern All Star')
eastern_all_star_team.add_player(Player.create(name: 'Camelo Anthony', number: 7))
eastern_all_star_team.add_player(Player.create(name: 'Paul George', number: 24))
eastern_all_star_team.add_player(Player.create(name: 'Lebron James', number: 6))
eastern_all_star_team.add_player(Player.create(name: 'Kyrie Irving', number: 2))
eastern_all_star_team.add_player(Player.create(name: 'Dwayne Wade', number: 3))
eastern_all_star_team.add_player(Player.create(name: 'Chris Bosh', number: 1))
eastern_all_star_team.add_player(Player.create(name: 'Joe Johnson', number: 7))
eastern_all_star_team.add_player(Player.create(name: 'Roy Hibbert', number: 55))
eastern_all_star_team.add_player(Player.create(name: 'Joakim Noah', number: 13))
eastern_all_star_team.add_player(Player.create(name: 'Paul Millsap', number: 4))

game = Game.create(gametime: DateTime.now)
game.add_team(western_all_star_team)
game.add_team(eastern_all_star_team)

Player.create(name: 'Steve Nash', number: 10)
Player.create(name: 'Klay Thompson', number: 20)


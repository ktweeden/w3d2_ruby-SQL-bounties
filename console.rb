require('pry-byebug')
require_relative('models/bounty')

bounty1 = Bounty.new({'name' => 'Woody Lightyear', 'bounty_value' => '200',
  'favourite_weapon' => 'whip', 'last_known_location' => 'Hoth'})

bounty2 = Bounty.new({'name' => 'Mal Serenity', 'bounty_value' => '1000',
  'favourite_weapon' => 'pistol', 'last_known_location' => 'Dagobar'})

binding.pry

nil

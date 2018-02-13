require('pg')

class Bounty
  attr_accessor :name, :bounty_value, :favourite_weapon, :last_known_location
  attr_reader :id

  def initialize(options)
    @id  = options['id'].to_i() if options['id']
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i()
    @favourite_weapon = options['favourite_weapon']
    @last_known_location = options['last_known_location']
  end

  def save()
    db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'})

    sql = "
    INSERT INTO bounties
    (
      name, bounty_value, favourite_weapon, last_known_location
    )
    VALUES
    (
      $1, $2, $3, $4
    );
    "
    values = [@name, @bounty_value, @favourite_weapon, @last_known_location]
    db.prepare("bounty", sql)
    db.exec_prepared("bounty", values)
    db.close
  end

  def update()
    db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'})
    sql =
    "
    UPDATE bounties
    SET
    (
      name, bounty_value, favourite_weapon, last_known_location
    ) =
    (
      $1, $2, $3, $4
    )
    WHERE id = $5;
    "
    values = [@name, @bounty_value, @favourite_weapon, @last_known_location, @id]
    db.prepare("updater", sql)
    db.exec_prepared("updater", values)
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'})
    sql =
    "
    DELETE FROM bounties
    WHERE id = $1;
    "

    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close
  end

  def self.find_by_name(qname)
    db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'})
    sql =
    "
    SELECT * FROM bounties
    WHERE name = $1;
    "
    values = [qname]
    db.prepare("finder", sql)
    results = db.exec_prepared("finder", values)
    db.close()
    return results.map {|result| Bounty.new(result)}
  end

  def self.find(attribute, value)
    db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'})
    sql =
    "
    SELECT * FROM bounties
    WHERE #{attribute} = $1;
    "

    values = [value]
    db.prepare("finder", sql)
    results = db.exec_prepared("finder", values)
    db.close
    return results.map {|result| Bounty.new(result)}
  end

end

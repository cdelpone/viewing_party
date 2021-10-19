class CastMember
  attr_reader :id,
              :name,
              :character

  def initialize(data)
    @id        = data[:id]
    @name      = data[:name]
    @character = data[:character]
  end
end

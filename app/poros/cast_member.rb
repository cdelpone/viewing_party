class CastMember
  attr_reader :id,
              :name,
              :character

  def initialize(info)
    @id = info[:id]
    @name = info[:name]
    @character = info[:character]
  end
end

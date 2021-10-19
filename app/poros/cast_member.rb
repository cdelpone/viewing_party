class CastMember
  attr_reader :id,
              :name,
              :character

  def initialize(params)
    @id        = params[:id]
    @name      = params[:name]
    @character = params[:character]
  end
end

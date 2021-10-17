class Review
  attr_reader :author,
              :author_details,
              :content,
              :created_at,
              :id,
              :updated_at,
              :url

  def initialize(info)
    @author = info[:author]
    @author_details = info[:author_details]
    @content = info[:content]
    @created_at = info[:created_at]
    @id = info[:id]
    @updated_at = info[:updated_at]
    @url = info[:url]
  end
end

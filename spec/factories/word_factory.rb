class WordFactory < AbstractFactory
  private

  attr_reader :name

  public

  attr_reader :word

  def initialize(name: 'Foo')
    @name = name
  end

  def create
    @word = ::Shirty::Entities::Word.create(name: name)
  end
end

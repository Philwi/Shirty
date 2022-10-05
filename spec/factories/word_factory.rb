class WordFactory < AbstractFactory
  private

  attr_reader :name

  public

  attr_reader :word

  def initialize(name: 'Foo')
    @name = name
  end

  def create
    @word = ::Shirty::Repositories::Words.new.create_word_by_name(name)
  end
end

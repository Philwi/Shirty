class BlueprintFactory < AbstractFactory
  attr_accessor :blueprint

  def initialize
  end

  def create_blueprint(blueprint_attributes: default_blueprint_attributes)
    self.blueprint = ::Shirty::Repositories::Printify::Blueprints.new.create(blueprint_attributes)
  end

  def stub_blueprint_request(blueprint_attributes: default_response_blueprint_attributes)
    allow_any_instance_of(::Shirty::Http::Printify::Blueprints).to receive(:all).and_return(blueprint_attributes)
  end

  private

  def default_blueprint_attributes
    {
      printify_id: '3',
      title: 'Blueprint 1',
      brand: 'Brand 1',
      model: 'Model 1',
      images: ['image1.jpg', 'image2.jpg'],
      description: 'Description 1'
    }
  end

  def default_response_blueprint_attributes
    [
      {
        'id': 3,
        'title': 'Kids Regular Fit Tee',
        'description': 'blabla',
        'brand': 'Delta',
        'model': '11736',
        'images': [
          'https:\/\/images.printify.com\/5853fe7dce46f30f8327f5cd',
          'https:\/\/images.printify.com\/5c487ee2a342bc9b8b2fc4d2'
        ]
      }
    ]
  end
end

require_relative '../../lib/shirty'

class ChangeAssociationsForNewShop < ActiveRecord::Migration[7.0]
  def change
    remove_column :images, :shopable_type
    remove_column :images, :shopable_id

    add_belongs_to :images, :shops, index: true

    shop = ::Shirty::Entities::Shop.create(name: 'I Hate Everything', prefix: 'I Hate')

    images = ::Shirty::Entities::Image.all
    images.each do |image|
      image.shop = shop
      image.save
    end
  end
end

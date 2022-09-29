module Shirty
  module Mapper
    module Printify
      class Image
        def parse(attributes)
          {
            printify_id: attributes['id'],
            file_name: attributes['file_name'],
            height: attributes['height'],
            width: attributes['width'],
            size: attributes['size'],
            mime_type: attributes['mime_type'],
            upload_time: attributes['upload_time']
          }
        end
      end
    end
  end
end

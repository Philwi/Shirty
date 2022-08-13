require_relative '../lib/shirty/entities/word'

file_path = File.join(File.expand_path('..', __dir__), 'words.txt')

if File.exist?(file_path)
  File.read(file_path).split("\n").each do |word|
    puts "Creating #{word}"
    ::Shirty::Entities::Word.create(name: word)
  end
else
  puts "File #{file_path} not found"
end

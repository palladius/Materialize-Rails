

$VERSION = File.read("#{Rails.root}/VERSION").strip

$CHANGELOG = File.read("#{Rails.root}/CHANGELOG").strip
$TODOS = File.read("#{Rails.root}/TODO.md").strip rescue "TODO.md missing"
$APPNAME = 'Lingotto'
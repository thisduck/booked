module EntryImport
  def self.import
    entries = YAML::load File.read(Rails.root + "export.yml")

    entries.each do |entry|
      Entry.collection.insert entry
    end
  end
end

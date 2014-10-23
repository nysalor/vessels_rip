# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def seed_data_dir
  File.join Rails.root, 'db', 'data'
end

YAML.load_file("#{seed_data_dir}/classifications.yml").each do |mst|
  s = Classification.find_or_initialize_by(id: mst["id"])
  s.name_ja = mst["name_ja"]
  s.name_en = mst["name_en"]
  s.save!
end

YAML.load_file("#{seed_data_dir}/causes.yml").each do |mst|
  s = Cause.find_or_initialize_by(id: mst["id"])
  s.description = mst["description"]
  s.save!
end

YAML.load_file("#{seed_data_dir}/vessels.yml").each do |mst|
  s = Vessel.find_or_initialize_by(id: mst["id"])
  s.name_ja = mst["name_ja"]
  s.name_en = mst["name_en"]
  s.type_name = mst["type_name"]
  s.sunk_at  = Time.zone.parse(mst["sunk_at"])
  s.place_name = mst["place_name"]
  s.latitude = mst["latitude"]
  s.longitude = mst["longitude"]
  s.classification_id = mst["classification_id"]
  s.cause_id = mst["cause_id"]
  s.save!
end


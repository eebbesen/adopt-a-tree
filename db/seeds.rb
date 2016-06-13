trees_file_path = Rails.root.join('db', 'trees.json')
trees_file      = File.read(trees_file_path)
trees_hash      = JSON.parse(trees_file)

# this is a weird nested hash
trees_meta = trees_hash["meta"]
# this is just a huge array
trees_data = trees_hash["data"]
# this is an array of all the field names
tree_fields = trees_meta['view']['columns'].map do |column|
  column['fieldName']
end

trees_data.each do |tree|
  Thing.find_or_create_by!(mpls_id: tree[8]) do |t|
    t.properties = {}
    tree_fields.map.with_index do |f, index|
      t.properties[tree_fields[index]] = tree[index]
    end

    t.mpls_unique = tree[9]
    t.lng         = tree[64]
    t.lat         = tree[65]
    t.species     = tree[66]
  end
end

Sponsor.create(name: "Minnepolis City Hall Brewery", 
               location: "350 S 5th St, Minneapolis, MN 55415",
               website: "https://cityhallbreweryminneapolis.com/adoptatree",
               lat: 44.977360,
               long: -93.265433)

Sponsor.create(name: "Biblioteka Brewery", 
               location: "300 Nicollet Mall, Minneapolis, MN 55401",
               website: "https://bibliotekabrewingminneapolis.com/adoptatree",
               lat: 44.980791,
               long: -93.270062)

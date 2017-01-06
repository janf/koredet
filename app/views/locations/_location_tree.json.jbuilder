json.key loc.id.to_s
json.title loc.name
json.parent loc.ancestry if loc.ancestry
json.location_type loc.location_type
json.root  "R" if loc.root?



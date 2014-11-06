attributes :id, :track_id, :user_id
node(:url) do |u|
  u.midi_file.url
end

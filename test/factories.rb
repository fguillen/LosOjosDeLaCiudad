Factory.define :camera do |f|
  f.sequence(:name) { |n| "camera_#{n}" }
  f.city "Wadus City"
end

Factory.define :history do |f|
  f.association :camera
  f.date Time.now
end
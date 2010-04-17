namespace :city_eyes do
  desc "Dustpan process"
  task :dustpan => :environment do
    CityEyes::DustpanProcessor.pick_images
  end
end
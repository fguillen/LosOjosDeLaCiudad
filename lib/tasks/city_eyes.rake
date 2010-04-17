namespace :city_eyes do
  desc "Dustpan process"
  task :dustpan => :environment do
    lapsus_time = 
      Benchmark.realtime do
        CityEyes::DustpanProcessor.pick_images
      end
    
    puts "Images captures on: #{lapsus_time} seconds"
  end
  
  desc "Generate all CSVs"
  task :csv_generation => :environment do
    puts "Generating all CSVs"
    CityEyes::CSVGenerator.csv_all
    puts "All CSVs generated"
  end
  
  desc "Digest all CSVs"
  task :csv_digest => :environment do
    puts "Digesting all CSVs"
    CityEyes::CSVDigester.digest_all
    puts "All CSVs Digested"
  end
end
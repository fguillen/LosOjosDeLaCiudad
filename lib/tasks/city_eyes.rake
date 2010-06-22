namespace :city_eyes do
  desc "Dustpan process"
  task :dustpan => :environment do
    puts "(#{Time.now}) Capturing images"
    
    lapsus_time = 
      Benchmark.realtime do
        CityEyes::DustpanProcessor.pick_images
      end
    
    puts "(#{Time.now}) Images captures on: #{lapsus_time} seconds"
  end
  
  desc "Generate all CSVs"
  task :csv_generation => :environment do
    puts "(#{Time.now}) Generating all CSVs"
    CityEyes::CSVGenerator.csv_all
    puts "All CSVs generated"
  end
  
  desc "Digest all CSVs"
  task :csv_digest => :environment do
    puts "(#{Time.now}) Digesting all CSVs"
    CityEyes::CSVDigester.digest_all
    puts "All CSVs Digested"
  end
  
  desc "Remove old Histories"
  task :remove_old_histories => :environment do
    puts "(#{Time.now}) Removing old Histories"
    History.cleaner_days_ago( 1 )
    puts "All old Histories removed"
  end
end
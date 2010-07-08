namespace :metropoli do
  task :cleanup => :environment do
    puts 'Cleaning up...'
      Metropoli::CountryModel.destroy_all
      Metropoli::StateModel.destroy_all
      Metropoli::CityModel.destroy_all
    puts 'Finished'
  end
end
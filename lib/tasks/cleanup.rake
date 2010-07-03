namespace :metropoli do
  task :cleanup => :environment do
    puts 'Cleaning up...'
      Metropoli::Country.destroy_all
      Metropoli::State.destroy_all
      Metropoli::City.destroy_all
    puts 'Finished'
  end
end
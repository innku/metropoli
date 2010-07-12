Factory.define 'city', :class => 'Metropoli::CityModel' do |c|
  c.name 'Monterrey'
  c.association :state, :factory => :state
end

Factory.define :state, :class => 'Metropoli::StateModel' do |s|
  s.name 'Nuevo Leon'
  s.abbr 'NLE'
  s.association :country, :factory => :country
end

Factory.define :country, :class => 'Metropoli::CountryModel' do |c|
  c.name 'Mexico'
  c.abbr 'MX'
end
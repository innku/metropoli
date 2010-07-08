#TODO Look for a better way to do this
if (Metropoli::CityModel.connection.adapter_name.downcase.include?('postgres'))
  Metropoli::LIKE = 'ILIKE'
else
  Metropoli::LIKE = 'LIKE'
end
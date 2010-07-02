if (Metropoli::City.connection.adapter_name.downcase.include?('postgres'))
  Metropoli::LIKE = 'ILIKE'
else
  Metropoli::LIKE = 'LIKE'
end
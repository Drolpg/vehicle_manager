namespace :rentals do
  desc "Finaliza aluguéis vencidos automaticamente"
  task expire: :environment do
    expired_rentals = Rental.expired

    puts "Encontrados #{expired_rentals.count} aluguéis vencidos."

    expired_rentals.find_each do |rental|
      rental.finish!
      puts "Aluguel ##{rental.id} finalizado com sucesso."
    end
  end
end

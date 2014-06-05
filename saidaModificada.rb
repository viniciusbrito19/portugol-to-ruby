class Fatorial 
attr_accessor  :res, :fat, :x 
	
	def fatorial
		puts "Digite um número:"
		@fat=gets
		puts fat(@fat.to_i) 
		
	end
	def fat(n)
		if(n>1)
			n * fat(n-1)
		else
			1
		end
	end
end

fat = Fatorial.new()
fat.fatorial

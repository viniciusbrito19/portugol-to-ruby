class Fatorial 
attr_accessor  :res, :fat, :x 
	
	def fatorial
		puts "Digite um número:"
		@fat=gets 
		
		@res=1

		for @x in @fat..1
			@x-=1
			@res = @res*@x
		end
		puts "Fatorial de ",@fat," é ",@res
	end
end

fat = Fatorial.new()
fat.fatorial

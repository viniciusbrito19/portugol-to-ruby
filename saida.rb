class Fatorial 
attr_accessor  :res, :fat, :x 

def fatorial
	puts "Digite um número:"
	@fat=gets 

	@res=1
	
	for @x in 10..1
		@x-=1

	@res=@res*@x
	end 
	puts "Resultado é: #{res}\n"
end
end
obj = Fatorial.new()
obj.fatorial

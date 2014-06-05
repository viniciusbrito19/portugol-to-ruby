class Fatorial 
attr_accessor  :res, :fat, :x, :idade 

def main
	puts "Digite um número:"
	@fat=gets 

	@res=1

	for @x in 1..@fat.to_i

	@res=@res*@x

	end 
	puts "Resultado é:",@res
end
end

obj = Fatorial.new()
obj.main

program testMod

	use modPoint
	implicit none
	type(Ponto) :: p1
	p1 = init(1.0,z=3.0)
	print*, getx(p1)

end program testMod














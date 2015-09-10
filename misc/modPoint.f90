module modPoint

	implicit none
	type Ponto
		private
		real :: x, y, z
	end type Ponto
	
	contains
		type(Ponto) function init(x,y,z)
			real, intent(in), optional :: x,y,z
			init = Ponto(0.0,0.0,0.0)
			if ( present(x) ) init%x = x
			if ( present(y) ) init%y = y
			if ( present(z) ) init%z = z
		end function init

		real function getx(p)
			type(Ponto), intent(in) :: p
			getx = p%x
		end function getx

end module modPoint


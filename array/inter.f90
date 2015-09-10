program inter

	implicit none
	interface clear
		subroutine clear_int(a)
			integer, intent(inout) :: a
			!print*, a
		end subroutine clear_int
		
		subroutine clear_real(a)
			real, intent(inout) :: a
			!print*, a
		end subroutine clear_real

	end interface ! clear

	subroutine clear_int(a)
		integer, intent(inout) :: a
		print*, a
	end subroutine clear_int

	subroutine clear_real(a)
		real, intent(inout) :: a
		print*, a
	end subroutine clear_real

	integer :: b = 1
	real :: r = 2.0
	call clear(b)
	call clear(r)
	
end program inter

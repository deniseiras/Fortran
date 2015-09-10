program subroutines

	implicit none
	integer, dimension(:), allocatable :: arr, fout

	arr = (/1,2,3,4/)
	print*, RANK(arr)
	print*, arr
	fout = f(arr)
	print*, fout
	call s(fout)
	print*, fout

contains
	function f(arrin)
		integer, dimension(:), intent(in) :: arrin
		integer, dimension(:), allocatable :: f
		f = arrin
		
	end function f

	subroutine s(arrin)
		integer, dimension(:), intent(inout) :: arrin
	end subroutine s

end program subroutines
program dimm

! 	implicit none
! 	integer, dimension(1:2,3:4) :: ika
! 	ika(1,3) = 13
! 	ika(2,3) = 23

! 	ika(1,4) = 14
! 	ika(2,4) = 24

! 	print*, ika(1,3)
! 	print*, ika(2,3)
! 	print*, ika(1,4)
! 	print*, ika(2,4)

	implicit none
	integer, dimension(1:2,3) :: ika
	ika(1,1) = 11
	ika(1,2) = 12
	ika(1,3) = 13

	print*, ika(1,1)
	print*, ika(1,2)
	print*, ika(1,3)
	print*, ika(1,1:3)
	print*, ika(2,1:3)


end program dimm


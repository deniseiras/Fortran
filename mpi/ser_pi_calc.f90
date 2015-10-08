! ************************************************************************
!  FILE: ser_pi_calc.f  
!  DESCRIPTION:  
!    Serial pi Calculation - Fortran Version 
!    This program calculates pi using a "dartboard" algorithm.  See
!    Fox et al.(1988) Solving Problems on Concurrent Processors, vol.1
!    page 207.  
!    Note: Requires Fortran90 compiler due to random_number() function
!  AUTHOR: unknown
!  LAST REVISED: 02/23/12 Blaise Barney 
! ************************************************************************
! Explanation of constants and variables used in this program:
!   DARTS               = number of throws at dartboard
!   ROUNDS              = number of times "DARTS" is iterated
!   pi                  = average of pi for this iteration
!   avepi               = average pi value for all iterations
! ************************************************************************

program pi_calc

  use pi
  use ranmdomize
  implicit none


	integer  DARTS, ROUNDS,i
	parameter(DARTS = 10000)
	parameter(ROUNDS = 8000)
  integer, allocatable :: seed(:)

  real*8 PI_REAL
  parameter(PI_REAL=3.1415926535897)

  real*4    seednum
  real*8    picalculated, avepi, start, finish

  print *,'Starting serial version of pi calculation...'
  call cpu_time(start)
 	avepi = 0
	do i = 1, ROUNDS
    call initRandomSeed()
	  picalculated = dboard(DARTS)
    avepi = ((avepi*(i-1)) + picalculated)/ i  
!   write(*,32) DARTS*i, avepi
! 32  format('   After',i8,' throws, average value of pi = ',f10.8,$)
  end do

  call cpu_time(finish)
  print *, 'Darts thown: ', ROUNDS*DARTS
  print *, 'Serial Time: ', finish-start
  write(*,'(" Difference: ",f10.8)') ABS(PI_REAL-avepi)
  print *,'Real value of PI: 3.1415926535897'
  print *, ' '

end program pi_calc
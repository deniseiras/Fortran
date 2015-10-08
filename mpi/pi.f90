module pi

contains 
! ************************************************************************
!  dboard.f
! ************************************************************************
! Explanation of constants and variables used in this function:
!   darts       = number of throws at dartboard
!   score       = number of darts that hit circle
!   n           = index variable
!   r           = random number between 0 and 1
!   x_coord     = x coordinate, between -1 and 1
!   x_sqr       = square of x coordinate
!   y_coord     = y coordinate, between -1 and 1
!   y_sqr       = square of y coordinate
!   pi          = computed value of pi
! ************************************************************************
function dboard(darts)

  integer   darts, score, n
  real*4    r
  real*8    x_coord, x_sqr, y_coord, y_sqr, pi, dboard

  score = 0

!  Throw darts at board.  Done by generating random numbers
!  between 0 and 1 and converting them to values for x and y
!  coordinates and then testing to see if they "land" in
!  the circle."  If so, score is incremented.  After throwing the
!  specified number of darts, pi is calculated.  The computed value
!  of pi is returned as the value of this function, dboard.
!  Note:  the seed value for rand() is set in pi_calc.

!    Note: Requires Fortran90 compiler due to random_number() function
  do n = 1, darts
    call random_number(r)
    x_coord = (2.0 * r) - 1.0
    x_sqr = x_coord * x_coord

    call random_number(r)
    y_coord = (2.0 * r) - 1.0
    y_sqr = y_coord * y_coord

    if ((x_sqr + y_sqr) .le. 1.0) then
      score = score + 1
    endif

  end do

  pi = 4.0 * score / darts
  dboard = pi
end function dboard

end module
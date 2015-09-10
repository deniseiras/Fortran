real :: a,b
integer :: i,j
namelist /input/ a,b,i,j
open(10,file='data.dat')
read(10,nml=input)
write(*,nml=input)
close(10)

! namelist data file
!        &input
!        b=12.3
!        i=4
!        a=13.2
!        j=12
!        /
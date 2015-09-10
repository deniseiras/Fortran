program monte_carlo
   !USE IFPORT
   implicit none

   integer*8 i, npts
   integer :: count, count_rate, count_max
   integer :: countf, count_ratef, count_maxf
   parameter (npts = 1e9)
   real*8 f,sum, randnum, xmin,xmax,x

   CALL SYSTEM_CLOCK(count, count_rate, count_max)
   xmin = 0.0d0
   xmax = 1.0d0
   
  CALL RANDOM_SEED() 
  CALL RANDOM_NUMBER(HARVEST = randnum) 
  print*, "numero randomico = ", randnum

   do i=1,npts
      CALL RANDOM_NUMBER(HARVEST = randnum) 
      x = (xmax-xmin)*randnum + xmin
      sum = sum + 4.0d0/(1.0d0 + x**2)
   enddo
   f = sum/npts
   
   CALL SYSTEM_CLOCK(countf, count_ratef, count_maxf)
   write(*,*)'PI calculated with ',npts,' points = ',f, " in ", countf-count, " miliseconds"
   print*, 'PI calculated with ',npts,' points = ',f, " in ", countf-count, " miliseconds"


stop
end
! ****************************************************************************
!  FILE: mpi_pi_send.f
!  DESCRIPTION:  
!    MPI pi Calculation Example - Fortran Version 
!    Point-to-Point Communication example
!    This program calculates pi using a "dartboard" algorithm.  See
!    Fox et al.(1988) Solving Problems on Concurrent Processors, vol.1
!    page 207.  All processes contribute to the calculation, with the
!    master averaging the values for pi. SPMD Version:  Conditional 
!    statements check if the process is the master or a worker.
!    This version uses low level sends and receives to collect results 
!    Note: Requires Fortran90 compiler due to random_number() function
!  AUTHOR: Blaise Barney. Adapted from Ros Leibensperger, Cornell Theory
!   Center. Converted to MPI: George L. Gusciora, MHPCC (1/95)  
!  LAST REVISED: 06/13/13 Blaise Barney
! ****************************************************************************
! Explanation of constants and variables used in this program:
!   DARTS          = number of throws at dartboard 
!   ROUNDS         = number of times "DARTS" is iterated 
!   MASTER         = task ID of master task
!   taskid         = task ID of current task 
!   numtasks       = number of tasks
!   homepi         = value of pi calculated by current task
!   pi             = average of pi for this iteration
!   avepi          = average pi value for all iterations 
!   pirecv         = pi received from worker 
!   pisum          = sum of workers' pi values 
!   seednum        = seed number - based on taskid
!   source         = source of incoming message
!   mtype          = message type 
!   i, n           = misc

program pi_send 

  use pi
  use ranmdomize
  implicit none

  include 'mpif.h'

  integer DARTS, MASTER, ROUNDS
  parameter(DARTS = 10000) 
  parameter(MASTER = 0)
  parameter(ROUNDS=1000)
  real PI_REAL
  parameter(PI_REAL=3.1415926535897)

  integer taskid, numtasks, source, mtype, i, n,status(MPI_STATUS_SIZE), ierr, sbytes
  real*4	seednum
  real*8 	homepi, picalculated, avepi, pirecv, pisum
  real*8  start, finish

  call MPI_INIT( ierr )
  call MPI_COMM_RANK( MPI_COMM_WORLD, taskid, ierr )
  call MPI_COMM_SIZE( MPI_COMM_WORLD, numtasks, ierr )
!   write(*,*)'task ID = ', taskid

  start = MPI_WTIME()
  avepi = 0

  do i = 1, ROUNDS
    call initRandomSeed()
    homepi = dboard(DARTS)

    if (taskid .ne. MASTER) then
      mtype = i 
      sbytes = 8	
      call MPI_SEND( homepi, 1, MPI_DOUBLE_PRECISION, MASTER, i,MPI_COMM_WORLD, ierr )
    else
      mtype = i	
      sbytes = 8
      pisum = 0
      do n = 1, numtasks-1
        call MPI_RECV( pirecv, 1, MPI_DOUBLE_PRECISION,&
          MPI_ANY_SOURCE, mtype, MPI_COMM_WORLD, status, ierr )
        pisum = pisum + pirecv
      end do
      picalculated = (pisum + homepi)/numtasks
      avepi = ((avepi*(i-1)) + picalculated) / i
!       write(*,32) DARTS*i, avepi
!   32     format('   After',i6,' throws, average value of pi = ',f10.8) 
    endif
  end do

  if (taskid .eq. MASTER) then
    print *, 'processadores: ', numtasks
    print *, 'Darts thown: ', ROUNDS*DARTS*numtasks
    finish = MPI_WTIME()
    print *, 'Tempo: ', finish-start
    write(*,'(" Difference: ",f10.8)') ABS(PI_REAL-avepi)
    print *,'Real value of PI: 3.1415926535897'
  endif

  call MPI_FINALIZE(ierr)

end program pi_send
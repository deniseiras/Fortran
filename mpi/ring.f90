program ring

  implicit none
  integer :: ierr, world_rank, world_size, token
  include 'mpif.h'

  call MPI_INIT(ierr)
  call MPI_COMM_RANK(MPI_COMM_WORLD, world_rank, ierr)
  call MPI_COMM_SIZE(MPI_COMM_WORLD, world_size, ierr)

  ! Receive from the lower process and send to the higher process. Take care
  ! of the special case when you are the first process to prevent deadlock.
  
  if (world_rank .NE. 0) then
    write(*,'("Process ",i2.0," will receive ",i2.0," from process ",i2.0)')&
      world_rank, token, world_rank-1
    call MPI_RECV(token, 1, MPI_INT, world_rank-1, 0, MPI_COMM_WORLD,&
             MPI_STATUS_IGNORE, ierr)

    write(*,'("Process ",i2.0," received token ",i2.0," from process ",i2.0)')&
      world_rank, token, world_rank-1
  else 
      !Set the token's value if you are process 0
    token = -1;
  end if
  write(*,'("Process ",i2.0," will send ",i2.0," to process ",i2.0)')&
      world_rank, token, MOD((world_rank+1),world_size)
  call MPI_SEND(token, 1, MPI_INT, MOD((world_rank+1),world_size), 0,&
    MPI_COMM_WORLD,ierr)
  write(*,'("Process ",i2.0," sended ",i2.0," to process ",i2.0)')&
      world_rank, token, MOD((world_rank+1),world_size)

  !Now process 0 can receive from the last process. This makes sure that at
  !least one MPI_Send is initialized before all MPI_Recvs (again, to prevent
  !deadlock)
  if (world_rank == 0) then
    write(*,'("Process ",i2.0," will receive ",i2.0," from process ",i2.0)')&
      world_rank, token, world_size-1
    call MPI_RECV(token, 1, MPI_INT, world_size-1, 0, MPI_COMM_WORLD,&
    MPI_STATUS_IGNORE, ierr)
    write(*,'("Process ",i2.0," received token ",i2.0," from process ",i2.0)')&
      world_rank, token, world_size-1
  end if
  call MPI_FINALIZE(ierr)

end program ring

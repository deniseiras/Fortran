program read_bsc_levels

use netcdf
implicit none

integer, parameter :: lon = 625, lat = 320, time = 25, lev = 15
real(kind=8), dimension(:), allocatable :: lon_nc, time_nc, lat_nc, lev_nc

real, dimension(:,:,:,:), allocatable :: dummy
real, dimension(:,:,:), allocatable :: dummy3d
real, dimension(:,:), allocatable :: dummy2d

character(len=*), parameter :: arquivo='bsc_interactive_20120413_reg.nc', dir='./'
character(len=255) :: filename

integer :: ncid, var_id, recIdx, x, y, z, t, recSize, nRecords, ios

! "DSET ^model.dat
! TITLE Modelo de Dados de exemplo
! UNDEF 0.10000E+16
! XDEF 144 linear   0 2.5
! YDEF  91 linear -90 2.0
! ZDEF   8 levels 1000 900 800 700 500 300 100 50
! TDEF   4 linear 00z01apr85 6hr
! VARS 2 
!    u 8 99 componente U
!    v 8 99 componente V
! ENDVARS"

  allocate (lon_nc(lon))
  allocate (lat_nc(lat))
  allocate (lev_nc(lev))
  allocate (time_nc(time))
  allocate (dummy(lon,lat,lev,time))

  filename=trim(dir)//trim(arquivo)

  print*, "******************************"
  print*, trim(filename)
  print*, "******************************"

  call check(nf90_open(trim(filename), NF90_NOWRITE,ncid))

!   call check(nf90_inq_varid(ncid,'lat', var_id))
!   call check(nf90_get_var(ncid, var_id, lat_nc))
!   call check(nf90_inq_varid(ncid,'lon', var_id))
!   call check(nf90_get_var(ncid, var_id, lon_nc))
!   call check(nf90_inq_varid(ncid,'pres', var_id))
!   call check(nf90_get_var(ncid, var_id, lev_nc))
!   call check(nf90_inq_varid(ncid,'time', var_id))
!   call check(nf90_get_var(ncid, var_id, time_nc))
!    call check(nf90_inq_varid(ncid,'tsl', var_id))
!    call check(nf90_get_var(ncid, var_id, dummy))
  
!    call check(nf90_inq_varid(ncid,'spd10', var_id))
!    call check(nf90_get_var(ncid, var_id, dummy))
  
     allocate (dummy3d(lon,lat,lev))
     call check(nf90_inq_varid(ncid,'spd10', var_id))
     call check(nf90_get_var(ncid, var_id, dummy3d))


!     allocate (dummy2d(lon,lat))
!     call check(nf90_get_var(ncid, var_id, dummy2d))

  open(10, file='teste.txt', action="write", status='replace')
  
    do x=1, lon
      do y=1, lat
        do t=1, time
          if( dummy3d(x, y, t) > 0 ) then
!               print*, "**************"
!               print*, x, y, z, t
!               print*, dummy(x, y, z, t)
            write(10,*) x,y,t, dummy3d(x, y, t)
          endif
        end do
      end do
    end do
    close(10)

!   nRecords = lev*time
!   recSize = (sizeof(dummy)/nRecords)
!   print*, rank(dummy)
!   print*, sizeof(dummy(:,1,1,1))
!   print*, sizeof(dummy)
!   print*, recSize

!   open(100, file='teste.txt', access='direct', form='unformatted', status='replace', recl=recSize)

!   do z=1, lev 
!     do t=1, time
! !        print*, dummy(:, :, z, t)
!        write(100, REC=recIdx) dummy(:, :, z, t)
!       recIdx = recIdx + 1
!     end do
!   end do


!   close(100)

  call check(nf90_close(ncid))

  deallocate (lon_nc)
  deallocate (lat_nc)
  deallocate (lev_nc)
  deallocate (time_nc)
  deallocate (dummy)



end program read_bsc_levels

subroutine check(status)
 use netcdf
 implicit none
  integer :: status

     IF(status /= nf90_noerr) THEN
         PRINT *, 'erro',status
         STOP
     ENDIF

END SUBROUTINE check

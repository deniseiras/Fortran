program read_bsc
use netcdf
implicit none
integer, parameter :: lon = 625
integer, parameter :: lat = 320
integer, parameter :: time = 25
integer, parameter :: lev = 15
real(kind=8), dimension(:), allocatable :: lon_nc
real(kind=8), dimension(:), allocatable :: lat_nc
real, dimension(:), allocatable :: lev_nc
real(kind=8), dimension(:), allocatable :: time_nc
real, dimension(:,:,:,:), allocatable :: dummy
 character(len=*), parameter :: arquivo='bsc_interactive_20120413_reg.nc'
 character(len=*), parameter :: dir='/stornext/online8/exp-dmd/aerosols/bsc/dust/interactive/'
 character(len=255) :: filename
integer :: ncid
integer :: var_id


    allocate (lon_nc(lon))
    allocate (lat_nc(lat))
    allocate (lev_nc(lev))
    allocate (time_nc(time))
    allocate (dummy(lon,lat,lev,time))

    filename=trim(dir)//trim(arquivo)

    print*, trim(filename)

    call check(nf90_open(trim(filename), NF90_NOWRITE,ncid))
        call check(nf90_inq_varid(ncid,'lat', var_id))
        call check(nf90_get_var(ncid, var_id, lat_nc))
        call check(nf90_inq_varid(ncid,'lon', var_id))
        call check(nf90_get_var(ncid, var_id, lon_nc))
        call check(nf90_inq_varid(ncid,'pres', var_id))
        call check(nf90_get_var(ncid, var_id, lev_nc))
        call check(nf90_inq_varid(ncid,'time', var_id))
        call check(nf90_get_var(ncid, var_id, time_nc))
        call check(nf90_inq_varid(ncid,'tsl', var_id))
        call check(nf90_get_var(ncid, var_id, dummy))

        print*, maxval(dummy)

        open(100, file='teste.gra', form='unformatted', status='replace')
            write(100) dummy
        close(100)
    call check(nf90_close(ncid))

    deallocate (lon_nc)
    deallocate (lat_nc)
    deallocate (lev_nc)
    deallocate (time_nc)
    deallocate (dummy)



end program read_bsc

subroutine check(status)
 use netcdf
 implicit none
  integer :: status

     IF(status /= nf90_noerr) THEN
         PRINT *, 'erro',status
         STOP
     ENDIF

END SUBROUTINE check

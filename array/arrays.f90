program arrays

	implicit none
	integer, dimension(:,:), allocatable :: arrr
	integer err
	allocate(arrr(2,2), stat=err)
	if (err /= 0) print *, "arrr: Allocation request denied"
	arrr(1,1) = 11
	arrr(1,2) = 12
	arrr(2,1) = 21
	arrr(2,2) = 22

	print*, arrr
	print*, arrr(1,:)
	print*, arrr(2,:)
	print*, arrr(:,1)
	print*, arrr(:,2)


	if (allocated(arrr)) deallocate(arrr, stat=err)
	if (err /= 0) print *, "arrr: Deallocation request denied"
	

end program arrays

program main
	
	character(len=10) :: inpe
	character(len=20) :: cptec
	call instituicao(inpe)
	call instituicao(cptec)

contains
	subroutine instituicao(instituicaoVariavel)
		character(len=*), intent(in) :: instituicaoVariavel
		print*, "tamanho da string = ", len(instituicaoVariavel)
	end subroutine instituicao

end program main
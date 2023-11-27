Program creat_file
implicit none
character(len=10)::my_name
integer:: age,kk

!File 1
open(unit=30,file='student.dat',form='formatted',access='direct',recl=20)    

do kk=1,4
    read(*,*) my_name, age
    write(30,'(A10,I3)',rec=kk) my_name, age
end do

end program
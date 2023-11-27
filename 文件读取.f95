program flie

integer::Age
real::Score
character(len=10)::My_Name


OPEN(30,FILE='A.DAT',form='formatted',access='sequential')
read(30,"(I5)")Age
write(*,"(I5)")Age
read(30,"(F5.1)")Score
write(*,"(F5.1)")Score
read(30,"(A10)")My_Name
write(*,"(A10)")My_Name

close(30)

end
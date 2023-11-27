program text
implicit none

integer::Age=19
real::Score=99.9
character(len=10)::My_Name='slj'

OPEN(UNIT=30,FILE='A.DAT',FORM='FORMATTED',ACCESS='SEQUENTIAL') !”–∏Ò ΩÀ≥–Ú

write(30,"(I5)")Age
write(30,"(F5.1)")Score
write(30,"(A10)")My_Name

close(30)

OPEN(UNIT=31,FILE='B.DAT',FORM='UNFORMATTED',ACCESS='DIRECT',RECL=100)

write(31,rec=1)Age
write(31,rec=10)Score
write(31,rec=20)My_Name

close(31)

OPEN(UNIT=32,FILE='C.DAT',FORM='UNFORMATTED',ACCESS='SEQUENTIAL')

write(32)Age
write(32)Score
write(32)My_Name

close(32)

OPEN(UNIT=33,FILE='D.DAT',FORM='FORMATTED',ACCESS='DIRECT',RECL=100)

write(33,"(I5)",rec=1)Age
write(33,"(F5.1)",rec=2)Score
write(33,"(A10)",rec=3)My_Name

close(33)

end
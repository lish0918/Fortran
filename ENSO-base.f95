program test

integer::x(60)
real::x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,enso(60),item=0,av=0,s

open(31,file='ENSO-index.txt',form="formatted",access="sequential")

print *,"ENSO值"
do i=1,60
    read(31,'(I8,F8.2,F8.2,F8.2,F8.2,F8.2,F8.2,F8.2,F8.2,F8.2,F8.2,F8.2,F8.2)')x(i),x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12
    enso(i)=(x1+x2+x3)/3
    av=av+enso(i)
    write(*,'(i8,f8.2)')x(i),enso(i)
end do

av=av/60

do i=1,60
    item=item+(enso(i)-av)**2
end do

s=sqrt(item/59)
print *,"标准方差= ",s


print *,"厄尔尼诺年"
do i=1,60
        if(abs(enso(i))>1.5*abs(s)) then
        write(*,'(i8,f8.2)'),x(i),enso(i)
    end if
end do

print *,"标准化"
do i=1,60
    write(*,'(f8.2)')(enso(i)-av)/s
end do

close(31)

end
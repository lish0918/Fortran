program text

integer::n,NN,ii,jj
real::sst(145,73),sstsum,enso(516),av=0.,s=0.,sw=0.,item=0.,f,ensow(129)
open(30,file='SST196001-200212mon_145X73.dat',form='unformatted',access='sequential')

do n=1,516
    NN=0
    sstsum=0.
    read(30)sst
    do jj=1,73
        do ii=1,145        
            if(ii>=77.and.ii<=97.and.jj>=35.and.jj<=39) then
                NN=NN+1
                sstsum=sstsum+sst(ii,jj)
            else
            end if
        enddo
    enddo
    enso(n)=sstsum/NN
    av=av+enso(n)
end do
av=av/516  

do  n=1,516
    enso(n)=enso(n)-av    !每月enso指数
    s=s+enso(n)
end do
        
do n=1,43
    ensow(n)=(enso((n-1)*12+1)+enso((n-1)*12+2)+enso((n-1)*12+3))/3   !enso值
    sw=sw+ensow(n)
end do

print *,"月平均enso指数",s/416
print *,"冬季平均enso指数",sw/43

do n=1,43
    item=item+(ensow(n)-sw/43)**2
end do

f=sqrt(item/42)
print *,"标准方差：",f

print *,"enso指数标准化"
do n=1,43
    write(*,'(f8.2)')(ensow(n)-sw/43)/f
end do

end
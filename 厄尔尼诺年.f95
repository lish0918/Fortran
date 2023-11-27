program text

integer::n,NN,ii,jj,m=0,mz=0,mf=0
real::sst(145,73),sstsum=0.,sm=0.,enso(516),av=0.,s=0.,sw=0.,item=0.,f,ensow(43)=0.,smz=0.,smf=0.,ensso(516)
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
    ensso(n)=sstsum/NN
    av=av+ensso(n)
end do
av=av/516  

do  n=1,516
    enso(n)=ensso(n)-av    !每月enso指数
end do
 
do n=1,43
   ensow(n)=(enso((n-1)*12+1)+enso((n-1)*12+2)+enso((n-1)*12+3))/3        !年
   sw=sw+ensow(n)
end do

!print *,"月平均enso指数",s/516
!print *,"年平均enso指数",sw/43

item=0.
do n=1,43
    item=item+(ensow(n)-sw/43)**2
end do

f=sqrt(item/42)
print *,"标准方差：",f

do n=1,43
    ensow(n)=(ensow(n)-sw/43)/f
end do

do n=1,43
    if(abs(ensow(n))>1.2*f) then !挑选出绝对值大于1.2方差的年份
        print *,1959+n,ensow(n),(ensso((n-1)*12+1)+ensso((n-1)*12+2)+ensso((n-1)*12+3))/3
        m=m+1
        sm=sm+(ensso((n-1)*12+1)+ensso((n-1)*12+2)+ensso((n-1)*12+3))/3
        if (ensow(n)>0) then
            mz=mz+1
            smz=smz+(ensso((n-1)*12+1)+ensso((n-1)*12+2)+ensso((n-1)*12+3))/3

        else
            mf=mf+1
            smf=smf+(ensso((n-1)*12+1)+ensso((n-1)*12+2)+ensso((n-1)*12+3))/3
        end if
    end if
end do
print *,"年份冬季平均SST：",sm/m
print *,"正ENSO指数年SST平均减掉负ENSO指数年SST平均：",smz/mz-smf/mf

close(30)

end
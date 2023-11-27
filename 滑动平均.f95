program test
implicit none

integer::i,j,m,num
real::tt,temp(58),lon,lat,t,item

open(10,file='ChinaTemp_winter_58year_1951-2008.dat',form='formatted',access='sequential')

do i=1,58
    m=0
    tt=0.
    do j=1,160
        read(10,*)num,lon,lat,t
        if(lon>=5.and.lon<=35.and.lat>=105.and.lat<=135) then
            m=m+1
            tt=tt+t*0.1
        end if
    end do
    temp(i)=tt/m
    print *,temp(i)
end do

print *,"九年滑动平均"
do i=1,50
    item=0.
    do j=0,8
        item=item+temp(i+j)
    end do
    print *,item/9
end do

end
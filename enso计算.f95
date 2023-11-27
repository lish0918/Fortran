program main
    integer :: year(16),i
    real :: temp(16),av=0,s=0,item
    open(31,file="HangZhou_temp_1.txt",form="formatted",access="sequential")
    open(32,file="HangZhou_temp_2.txt",form="formatted",access="sequential")
    open(33,file="HangZhou_temp_3.txt",form="formatted",access="sequential")
    open(30,file="HangZhou_temp_1993-2008.txt",form="formatted",access="sequential")
    do i=0,15
        read(30,'(I8,F8.2)')year(i),temp(i)
        av=av+temp(i)
    end do
    av=av/16
    
    do i=0,15
        write(31,'(f8.2)')temp(i)
        write(32,'(f8.2)')av
        s=s+(av-temp(i))*(av-temp(i))
    end do
    s=sqrt(s/15)  !±ê×¼²î
    do i=0,15
        item=(temp(i)-av)/s   !enso
        write(33,'(f8.2)')item
    enddo
    
    close(30)
    close(31)
    close(32)

end
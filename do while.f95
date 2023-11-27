program text

integer::n=0,x,s=0
do while(n<5)
    read *,x
    if(mod(x,2)/=0) then
        s=s+x
        n=n+1
    end if
end do
print *,s

end
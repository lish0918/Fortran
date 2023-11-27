program test
    
real::p,s
integer::a,b,c

read*,a,b,c
if(a+b>c.and.a+c>b.and.b+c>a) then
    p=0.5*(a+b+c)
    s=sqrt(p*(p-a)*(p-b)*(p-c))
    print*,s
else
    print*,"Êı¾İ´íÎó"
end if

end
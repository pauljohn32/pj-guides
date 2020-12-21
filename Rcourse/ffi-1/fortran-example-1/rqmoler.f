c	This is file rqmoler.f (Nash, p. 245)
c     Typed from book by Paul E. Johnson, who is responsible for errors!
c     Create shared library with R CMD SHLIB rqmoler.f
      subroutine rqmoler(n, x, rq)
       integer n, i, j
       double precision x(n), ax(n), sum, rq
c     return rq = t(x) *A* x / (t(x) * x) for A = moler matrix
c     A[i, j] = min(i,j)-2 for i<>j, or i for i==j
       do 20 i=1,n
          sum=0.0
          do 10 j=1,n
             if (i.eq.j) then
                sum = sum+i*x(i)
             else
                sum = sum+(min(i,j)-2)*x(j)
             endif
 10       continue
          ax(i)=sum
 20    continue
       rq=0.0
       sum=0.0
       do 30 i=1,n
          rq = rq + ax(i)*x(i)
          sum = sum + x(i)**2
 30    continue
       rq = rq/sum
       return
       end


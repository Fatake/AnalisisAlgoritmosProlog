def A(m, n, s="%s"):
    print (s % ("A(%d,%d)" % (m, n)))
    if m == 0:
        return n + 1
    if n == 0:
        return A(m - 1, 1, s)
    n2 = A(m, n - 1, s % ("A(%d,%%s)" % (m - 1)))
    return A(m - 1, n2, s)

#x = int(input("Valor de m \n->"))
#print (x)

#y = int(input("Valor de N \n->"))
#print (y)
#print ("\nCalculando Ackerman"+str(x)+","+str(y))
print (A(4,1)) 

#### LU decomposition algo


function LU_dec(A :: Matrix{Float16})
    n = size(A)[1]
    for p in 1: n
        for r in p+1: n
            s = -A[r, p] / A[p, p]
            A[r, p] = -s
            for c in p+1: n
                A[r, c] = A[r, c] + s * A[p, c]
            end
        end
    end 

    return A
end


A = Float16[1 3 6; 2 5 1; 7 -1 4]

decom_A = LU_dec(A)
println(decom_A)
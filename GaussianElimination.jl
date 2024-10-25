# Write the matrix and the coefficients' vector


A = Float64[1 2 1; 2 6 1; 1 1 4]
b = Float64[2; 7; 3]

### write the augmented matrix
# concatenate the matrix
C = [A;;b]


function GaussElim(aug_matrix :: Matrix{Float64})
    n = size(aug_matrix)[1]  ### n equations == n rows
    for j in 1:n
        if aug_matrix[j, j] == 0
            println("The matrix is not regular, try another matrix, please.")
            break
        else
            for i in j+1:n
                l_ij = aug_matrix[i, j] / aug_matrix[j, j]
                aug_matrix[i, :] -= l_ij * aug_matrix[j, :]
            end
        end
    end

    return aug_matrix
end


V = GaussElim(C)
println(V[1:3, 1:3])  ## upper triangular matrix !!!
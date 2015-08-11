module TestLightGraphs
using LightGraphs
using GraphMatrices
using FactCheck
include("types.jl")

using TestGraphMatrices

import GraphMatrices.CombinatorialAdjacency

function CombinatorialAdjacency(A)
    D = float(indegree(A, vertices(A)))
    return CombinatorialAdjacency{Float64, typeof(A), typeof(D)}(A,D)
end

facts("constructors") do
    g = PathGraph(10)
    Ag = CombinatorialAdjacency(g)
    Am = CombinatorialAdjacency(adjacency_matrix(g))
    @fact Ag => truthy
end

facts("constructors") do
	n = 10
    mat = PathGraph(10)
	context("Adjacency") do
        test_adjacency(mat)
    end

	context("Laplacian") do
        test_laplacian(mat)
    end

	context("Accessors") do
        test_accessors(mat, n)
    end
end


facts("arithmetic") do
	n = 10
    mat = PathGraph(10)
    test_arithmetic(mat, n)
end

facts("other tests") do
    n = 10
    mat = PathGraph(10)
    test_other(mat, n)
end

end

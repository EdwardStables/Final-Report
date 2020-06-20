function Poll(p::DSProblem{T})::IterationOutcome where T
    points = GeneratePollPoints(p, p.mesh)
    return EvaluatePoint!(p, points)
end

#TODO this needs to use the poll size parameter not the mesh size parameter
# Mostly implements definition 2.6 from Audet & Dennis 2009
#function GeneratePollPoints(p::DSProblem{T}, ::AbstractMesh)::Vector{Vector{T}} where T
#    points = []
#    dirs = GenerateDirections(p)
#
#    !isnothing(p.x) && append!(points, [p.x + (p.mesh.Δᵐ*p.meshscale.*d) for d in eachcol(dirs)])
#    !isnothing(p.i) && append!(points, [p.i + (p.mesh.Δᵐ*p.meshscale.*d) for d in eachcol(dirs)])
#
#    return points
#end

GenerateDirections(p::DSProblem) = GenerateDirections(p, p.poll)



function GeneratePollPoints(p::DSProblem{T}, ::AbstractMesh
                           )::Vector{Vector{T}} where T
    points = []
    dirs = GenerateDirections(p)

    if !isnothing(p.x)
        append!(points, [p.x+(p.mesh.Δᵐ*p.meshscale.*d) for d in eachcol(dirs)])
    end
    if !isnothing(p.i)
        append!(points, [p.i+(p.mesh.Δᵐ*p.meshscale.*d) for d in eachcol(dirs)])
    end

    return points
end

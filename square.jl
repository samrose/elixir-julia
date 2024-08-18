function square(x)
    return parse(Float64, x)^2
end

if length(ARGS) > 0
    result = square(ARGS[1])
    println(result)
else
    println("Please provide a number as an argument.")
end

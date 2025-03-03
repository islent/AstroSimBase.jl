using Test
using AstroSimBase

@testset "Traits" begin
    @test NormalMode() isa LoggingMode
    @test ProgressMode() isa LoggingMode
    @test SilentMode() isa LoggingMode

    @test Newton() isa GravityModel
    @test MOND1983Milgrom() isa GravityModel
    @test QUMOND() isa GravityModel

    @test CPU() isa DeviceType
    @test GPU() isa DeviceType

    @test Euler() isa TimeIntegration
    @test Leapfrog() isa TimeIntegration
    @test RK4() isa TimeIntegration

    @test Periodic() isa BoundaryCondition
    @test Dirichlet() isa BoundaryCondition
    @test Vacuum() isa BoundaryCondition
    @test Newman() isa BoundaryCondition
    @test Reflective() isa BoundaryCondition
end

@testset "Functions" begin
    @test isnothing(emptyfunction("Input anything"))
    @test traitstring(CPU()) == "CPU"

    folder = "output"
    if isdir(folder)
        rm(folder, force=true, recursive=true)
    end
    mkpathIfNotExist(folder)
    mkpathIfNotExist(folder)

    @test_broken need_to_interrupt("output")
    interrupt("output")
    @test need_to_interrupt("output")
    @test need_to_interrupt("output", remove = true)

    @test isfile("output/stop")
    sleep(0.2)
    @test !isfile("output/stop")

    r = randin(Float32,2,3)
    @test 2<=r<=3

    r = randin(2,3)
    @test 2<=r<=3

    @test middle_exp([0,1,exp(1),1,0]) == 1

    ## find functions
    @test findfirstzero([-1, 0, 1]) == 1

    @test all(
        findzero([-1, 0, 1, 0, -1]) .== [1, 2, 3, 4]
    )
    @test all(
        findzero([-2, -1, 0, 1, 2]) .== [2, 3]
    )
    
    @test findfirstvalue([1,2,3], 2) == 1
    
    @test all(
        findvalue([1,2,3,2,1], 2) .== [1, 2, 3, 4]
    )
    @test all(
        findvalue([1,2,3,4,5], 3) .== [2, 3]
    )
end

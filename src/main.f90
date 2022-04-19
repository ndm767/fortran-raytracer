program Raytracer
    use :: class_vec3

    implicit none

    ! variable declarations
    integer :: width, height
    integer :: x, y ! loop variables
    real :: r, g, b ! color variables
    integer :: ir, ig, ib ! integer colors
    type(vec3) :: v1, v2, v3
    v1 = vec3_create(1.0, 2.0, 3.0)
    v2 = vec3_create(3.0, 2.0, 1.0)
    v3 = v2 - v1
    call vec3_print(v1)
    call vec3_print(v2)
    call vec3_print(v3)

    ! variable definitions
    width = 400
    height = 400

    ! open the output file
    open(1, file = "image.ppm", status = "new")
    write (1, '(A,/,I3,A,I3,/,A,/)', advance='no') "P3", width, " ", height, "255"

    do x = 0, width-1
        do y = 0, height-1
            r = real(x) / (real(width) - 1.0)
            g = real(y) / (real(height) - 1.0)
            b = 0.25

            ir = int(255.99 * r)
            ig = int(255.99 * g)
            ib = int(255.99 * b)

            write(1, '(I3,A,I3,A,I3,/)', advance='no') ir, " ", ig, " ", ib

        end do 
    end do 
end program Raytracer
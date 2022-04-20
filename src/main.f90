program Raytracer
    use :: class_vec3
    use :: class_ray
    use :: class_sphere

    implicit none

    ! variable declarations
    integer :: width, height
    integer :: x, y ! loop variables
    real :: loc_x, loc_y, loc_z ! current pixel location
    integer :: ir, ig, ib ! integer colors
    type(ray) :: pixel_ray ! ray for camera
    type(vec3) :: ray_color ! ray output color
    type(sphere) :: main_sphere

    ! variable definitions
    width = 400
    height = 400

    main_sphere = sphere_create(vec3_create(0.0, 0.0, 2.0), 1.0)

    ! open the output file
    open(1, file = "image.ppm", status = "new")
    write (1, '(A,/,I3,A,I3,/,A,/)', advance='no') "P3", width, " ", height, "255"

    do x = 0, width-1
        do y = 0, height-1
            loc_x = real(x) / (real(width)/2.0) - 1.0
            loc_y = real(y) / (real(height)/2.0) - 1.0
            loc_z = 0.0

            pixel_ray = ray_create(vec3_create(loc_x, loc_y, loc_z), vec3_create(0.0, 0.0, 1.0))
            ray_color = get_ray_color(pixel_ray, main_sphere)


            ir = int(255.99 * ray_color%v(1))
            ig = int(255.99 * ray_color%v(2))
            ib = int(255.99 * ray_color%v(3))

            write(1, '(I3,A,I3,A,I3,/)', advance='no') ir, " ", ig, " ", ib

        end do 
    end do 

contains
    function get_ray_color(r, s) result (c)
        use :: class_ray
        use :: class_vec3
        use :: class_sphere

        implicit none
        
        type(ray), intent(in) :: r
        type(sphere), intent(in) :: s
        type(vec3) :: c

        if (sphere_hit(r, s) .eqv. .true.) then
            c = vec3_create(1.0, 0.0, 0.0)
        else
            c = vec3_create(0.0, 0.0, 0.0)
        end if

    end function get_ray_color


end program Raytracer
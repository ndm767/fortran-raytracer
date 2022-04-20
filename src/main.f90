program Raytracer
    use :: class_vec3
    use :: class_ray
    use :: class_sphere
    use :: class_light

    use :: sdl_binding

    implicit none

    ! variable declarations
    integer :: width, height ! window width and height
    integer :: x, y ! loop variables
    real :: loc_x, loc_y, loc_z ! current pixel location
    type(ray) :: pixel_ray ! ray for camera
    type(vec3) :: ray_color ! ray output color
    type(sphere), dimension(3) :: spheres ! all the spheres in the scene
    type(light), dimension(1) :: lights ! all the lights in the scene


    ! variable definitions
    width = 400
    height = 400

    spheres(1) = sphere_create(vec3_create(0.0, 0.0, 2.0), 0.5, vec3_create(1.0, 0.0, 0.0))
    spheres(2) = sphere_create(vec3_create(1.0, 0.0, 3.0), 0.5, vec3_create(0.0, 1.0, 0.0))
    spheres(3) = sphere_create(vec3_create(0.0, -1.0, 2.5), 0.5, vec3_create(0.0, 0.0, 1.0))

    lights(1) = light_create(vec3_create(1.0, 1.0, 1.0), 10.0)


    call sdl_init(width, height)

    do x = 0, width-1
        do y = 0, height-1
            loc_x = real(x) / (real(width)/2.0) - 1.0
            loc_y = real(y) / (real(height)/2.0) - 1.0
            loc_z = 0.0

            pixel_ray = ray_create(vec3_create(loc_x, loc_y, loc_z), vec3_create(0.0, 0.0, 1.0))
            ray_color = get_ray_color(pixel_ray, spheres)

            call sdl_draw_pixel(x, y, ray_color%v(1), ray_color%v(2), ray_color%v(3))

        end do 
    end do 

    do while (sdl_is_running() == 1)
        call sdl_render()
    end do

    call sdl_quit()

contains
    function get_ray_color(r, s) result (c)
        use :: class_ray
        use :: class_vec3
        use :: class_sphere

        implicit none
        
        type(ray), intent(in) :: r
        type(sphere), dimension(:), intent(in) :: s
        type(vec3) :: c
        type(vec3) :: curr_pos
        real :: sphere_dist
        real :: closest_found
        type(sphere) :: closest_sphere
        integer :: i 
        logical :: s_found

        s_found = .false.

        ! initialize the closest found sphere to the farthest possible distance
        closest_found = huge(1.0)

        ! initialize the camera position to a constant right now
        curr_pos = vec3_create(0.0, 0.0, 0.0)

        ! go through all of the spheres
        do i = 1, size(s)
            ! if one is hit, see if its the closest one thats been hit and if it is, assign the output color to it
            if (sphere_hit(r, s(i)) .eqv. .true.) then
                s_found = .true.
                sphere_dist = vec3_length(s(i)%c - curr_pos)
                if(sphere_dist < closest_found) then
                    closest_sphere = s(i)
                end if 
            end if
        end do

        if (s_found .eqv. .true.) then
            c = closest_sphere%col
        else
            c = vec3_create(0.0, 0.0, 0.0)
        end if

    end function get_ray_color


end program Raytracer
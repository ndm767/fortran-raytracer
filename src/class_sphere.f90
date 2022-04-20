module class_sphere
    use :: class_vec3
    use :: class_ray

    implicit none 

    private 
    public :: sphere, sphere_create, sphere_hit

    type sphere
        type(vec3) :: c
        type(vec3) :: col
        real :: r
    end type sphere

    contains

    function sphere_create(center, radius, color) result (s)
        type(vec3), intent(in) :: center, color
        real, intent(in) :: radius
        type(sphere) :: s
        s%c = center
        s%r = radius
        s%col = color
    end function sphere_create

    function sphere_hit(curr_ray, curr_sphere) result (did_hit)
        type(ray), intent(in) :: curr_ray
        type(sphere), intent(in) :: curr_sphere
        logical :: did_hit
        type(vec3) :: oc
        real :: a, b, c, disc

        oc = curr_ray%orig - curr_sphere%c
        a = vec3_dot(curr_ray%dir, curr_ray%dir)
        b = vec3_dot(oc * 2.0, curr_ray%dir)
        c = vec3_dot(oc, oc) - curr_sphere%r**2

        disc = b*b - 4.0 * a * c

        if (disc > 0) then
            did_hit = .true.
        else
            did_hit = .false.
        end if

    end function sphere_hit
end module class_sphere
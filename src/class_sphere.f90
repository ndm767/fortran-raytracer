module class_sphere
    use :: class_vec3
    use :: class_ray
    use :: class_hitdata

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

    subroutine sphere_hit(curr_ray, curr_sphere, did_hit, hit_data)
        type(ray), intent(in) :: curr_ray
        type(sphere), intent(in) :: curr_sphere
        logical, intent(out) :: did_hit
        type(hitdata), intent(out) :: hit_data
        type(vec3) :: oc
        real :: a, b, c, disc, x

        oc = curr_ray%orig - curr_sphere%c
        a = vec3_dot(curr_ray%dir, curr_ray%dir)
        b = vec3_dot(oc * 2.0, curr_ray%dir)
        c = vec3_dot(oc, oc) - curr_sphere%r**2

        disc = b*b - 4.0 * a * c

        if (disc > 0) then
            did_hit = .true.

            x = -b
            if (b > 0) then
                x = x + sqrt(disc)
            else
                x = x - sqrt(disc)
            end if

            x = x/(2*a)
            hit_data%hitpos = ray_at(curr_ray, x)
            hit_data%hitnorm = hit_data%hitpos - curr_sphere%c
            hit_data%hitcolor = curr_sphere%col
        else
            did_hit = .false.
        end if

    end subroutine sphere_hit
end module class_sphere
module class_ray
    use :: class_vec3

    implicit none

    private
    public :: ray, ray_create, ray_at

    type ray
        type(vec3) :: orig, dir
    end type ray

contains
    function ray_create(o, d) result (r)
        type(vec3), intent(in) :: o, d
        type(ray) :: r

        r%orig = o
        r%dir = d
    end function ray_create

    function ray_at(r, t) result (loc)
        type(ray), intent(in) :: r
        real, intent(in) :: t 
        type(vec3) :: loc

        loc = r%orig + r%dir * t
    end function ray_at


end module class_ray
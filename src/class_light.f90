module class_light
    use :: class_vec3

    implicit none

    private 
    public :: light, light_create

    type light
        type(vec3) :: pos
        real :: int
    end type light

    contains

    function light_create(position, intensity) result (l)
        type(vec3), intent(in) :: position
        real, intent(in) :: intensity
        type(light) :: l

        l%pos = position
        l%int = intensity
    end function light_create

end module class_light
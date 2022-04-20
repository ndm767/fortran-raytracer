module class_hitdata
    use :: class_vec3

    implicit none

    private 
    public :: hitdata

    type hitdata
        type(vec3) :: hitpos, hitnorm, hitcolor
    end type hitdata
end module class_hitdata
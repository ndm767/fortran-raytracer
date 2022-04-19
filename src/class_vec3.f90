module class_vec3
    implicit none 
    private :: vec3_add, vec3_sub 
    public :: vec3, vec3_print, vec3_create

    type vec3
        real :: v(3)
    end type vec3

    interface operator(+)
       module procedure vec3_add 
    end interface

    interface operator(-)
        module procedure vec3_sub
    end interface


contains
    subroutine vec3_print(this)
        type(vec3), intent(in) :: this
        print *, "Vec3=", this%v(1), " ", this%v(2), " ", this%v(3)
    end subroutine

    function vec3_create(val1, val2, val3) result(vec)
        real, intent(in) :: val1, val2, val3
        type(vec3) :: vec

        vec%v(1) = val1
        vec%v(2) = val2
        vec%v(3) = val3
    end function vec3_create

    function vec3_add(v1,v2) result (added)
        type(vec3), intent(in) :: v1, v2
        type(vec3) :: added
        integer :: i

        do i = 1, 3
            added%v(i) = v1%v(i) + v2%v(i)
        end do
    end function vec3_add

    function vec3_sub(v1,v2) result (added)
        type(vec3), intent(in) :: v1, v2
        type(vec3) :: added
        integer :: i

        do i = 1, 3
            added%v(i) = v1%v(i) - v2%v(i)
        end do
    end function vec3_sub
end module class_vec3
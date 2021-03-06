module class_vec3
    implicit none 
    private :: vec3_add, vec3_sub, vec3_mult, vec3_div
    public :: vec3, vec3_print, vec3_create, vec3_length, vec3_dot, vec3_cross, vec3_normalize

    type vec3
        real :: v(3)
    end type vec3

    interface operator(+)
       module procedure vec3_add 
    end interface

    interface operator(-)
        module procedure vec3_sub
    end interface

    interface operator(*)
        module procedure vec3_mult
    end interface

    interface operator(/)
        module procedure vec3_div
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

    function vec3_length(this) result (len)
        type(vec3), intent(in) :: this
        real :: len
        integer :: i

        len = 0

        do i = 1, 3
            len = len + this%v(i)**2
        end do
        
        len = sqrt(len)
    end function vec3_length

    function vec3_mult(this, t) result (vec)
        type(vec3), intent(in) :: this 
        real, intent(in) :: t
        type(vec3) :: vec 

        integer :: i

        do i = 1, 3
            vec%v(i) = this%v(i) * t
        end do
    end function vec3_mult

    function vec3_div(this, t) result (vec)
        type(vec3), intent(in) :: this 
        real, intent(in) :: t
        type(vec3) :: vec 

        integer :: i

        do i = 1, 3
            vec%v(i) = this%v(i) / t
        end do
    end function vec3_div

    function vec3_dot(v1, v2) result (dp)
        type(vec3), intent(in) :: v1, v2
        real :: dp
        integer :: i

        dp = 0
        
        do i = 1, 3
            dp = dp + v1%v(i)*v2%v(i)
        end do
    end function vec3_dot

    function vec3_cross(v1, v2) result (cp)
        type(vec3), intent(in) :: v1, v2
        type(vec3) :: cp

        cp%v(1) = v1%v(2)*v2%v(3) - v1%v(3)*v2%v(2)
        cp%v(2) = v1%v(3)*v2%v(1) - v1%v(1)*v2%v(3)
        cp%v(3) = v1%v(1)*v2%v(2) - v1%v(2)*v2%v(1)
    end function vec3_cross

    function vec3_normalize(this) result (norm_vec)
        type(vec3), intent(in) :: this
        type(vec3) :: norm_vec

        norm_vec = this / vec3_length(this)
    end function vec3_normalize
        
end module class_vec3
module sdl_binding
    interface
        subroutine sdl_init(width, height) BIND(C, name='sdl_init')
            use, intrinsic :: iso_c_binding
            implicit none
            integer (c_int), value :: width, height
        end subroutine sdl_init

        subroutine sdl_draw_pixel(x, y, r, g, b) BIND(C, name='sdl_draw_pixel')
            use, intrinsic :: iso_c_binding
            implicit none
            integer (c_int), value :: x, y
            real (c_float), value :: r, g, b
        end subroutine sdl_draw_pixel

        subroutine sdl_render() BIND(C, name='sdl_render')
            use, intrinsic :: iso_c_binding
            implicit none
        end subroutine sdl_render

        subroutine sdl_quit() BIND(C, name='sdl_quit')
            use, intrinsic :: iso_c_binding
            implicit none
        end subroutine sdl_quit

        integer (c_int) function sdl_is_running() BIND(C, name='sdl_is_running')
            use, intrinsic :: iso_c_binding
            implicit none
        end function sdl_is_running

    end interface 
end module sdl_binding
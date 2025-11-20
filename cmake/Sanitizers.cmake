function(enable_sanitizers target)
  if(
    CMAKE_CXX_COMPILER_ID STREQUAL "GNU"
    OR CMAKE_CXX_COMPILER_ID MATCHES ".*Clang"
    OR CMAKE_C_COMPILER_ID STREQUAL "GNU"
    OR CMAKE_C_COMPILER_ID MATCHES ".*Clang"
  )
    set(SANITIZERS "")

    # UBSAN
    option(
      ENABLE_SANITIZER_UNDEFINED_BEHAVIOR
      "Enable undefined behavior sanitizer"
      TRUE
    )

    if(ENABLE_SANITIZER_UNDEFINED_BEHAVIOR)
      message(STATUS "${target}: Enabling undefined behavior sanitizer")
      list(APPEND SANITIZERS "undefined")
    endif()

    set(extra_sanitizers none address thread leak)
    if(NOT APPLE)
      list(APPEND extra_sanitizers memory)
    endif()

    if(NOT EXTRA_SANITIZER)
      set(EXTRA_SANITIZER "address" CACHE STRING "Sanitizer other than UBSAN")
    endif()

    set_property(CACHE EXTRA_SANITIZER PROPERTY STRINGS ${extra_sanitizers})

    if(EXTRA_SANITIZER AND NOT "${EXTRA_SANITIZER}" STREQUAL "none")
      list(APPEND SANITIZERS ${EXTRA_SANITIZER})
      message(STATUS "${target}: Enabling ${EXTRA_SANITIZER} sanitizer")
    endif()

    list(JOIN SANITIZERS "," LIST_OF_SANITIZERS)
  endif()

  if(LIST_OF_SANITIZERS)
    if(NOT "${LIST_OF_SANITIZERS}" STREQUAL "")
      target_compile_options(
        ${target}
        PRIVATE "$<$<CONFIG:DEBUG>:-fsanitize=${LIST_OF_SANITIZERS}>"
      )
      target_link_options(
        ${target}
        PUBLIC "$<$<CONFIG:DEBUG>:-fsanitize=${LIST_OF_SANITIZERS}>"
      )

      if(WIN32)
        if(MSVC AND ${EXTRA_SANITIZER} STREQUAL "address")
          # Add ASan flags for compilation and linking
          add_compile_options("$<$<CONFIG:Sanitize>:/fsanitize=address>")
          add_link_options("$<$<CONFIG:Sanitize>:/fsanitize=address>")
        endif()
        set_property(
          GLOBAL
          PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>"
        )
      endif()
    endif()
  endif()
endfunction()

# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "geometric_traking: 2 messages, 0 services")

set(MSG_I_FLAGS "-Igeometric_traking:/home/luca-phd/catkin_ws/src/geometric_traking/msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/indigo/share/sensor_msgs/cmake/../msg;-Ipcl_msgs:/opt/ros/indigo/share/pcl_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/indigo/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genjava REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(geometric_traking_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShapes.msg" NAME_WE)
add_custom_target(_geometric_traking_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "geometric_traking" "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShapes.msg" "geometric_traking/TrackedShape:std_msgs/Header"
)

get_filename_component(_filename "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg" NAME_WE)
add_custom_target(_geometric_traking_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "geometric_traking" "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg" "std_msgs/Header"
)

#
#  langs = gencpp;genjava;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(geometric_traking
  "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShapes.msg"
  "${MSG_I_FLAGS}"
  "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometric_traking
)
_generate_msg_cpp(geometric_traking
  "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometric_traking
)

### Generating Services

### Generating Module File
_generate_module_cpp(geometric_traking
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometric_traking
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(geometric_traking_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(geometric_traking_generate_messages geometric_traking_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShapes.msg" NAME_WE)
add_dependencies(geometric_traking_generate_messages_cpp _geometric_traking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg" NAME_WE)
add_dependencies(geometric_traking_generate_messages_cpp _geometric_traking_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(geometric_traking_gencpp)
add_dependencies(geometric_traking_gencpp geometric_traking_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS geometric_traking_generate_messages_cpp)

### Section generating for lang: genjava
### Generating Messages
_generate_msg_java(geometric_traking
  "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShapes.msg"
  "${MSG_I_FLAGS}"
  "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genjava_INSTALL_DIR}/geometric_traking
)
_generate_msg_java(geometric_traking
  "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genjava_INSTALL_DIR}/geometric_traking
)

### Generating Services

### Generating Module File
_generate_module_java(geometric_traking
  ${CATKIN_DEVEL_PREFIX}/${genjava_INSTALL_DIR}/geometric_traking
  "${ALL_GEN_OUTPUT_FILES_java}"
)

add_custom_target(geometric_traking_generate_messages_java
  DEPENDS ${ALL_GEN_OUTPUT_FILES_java}
)
add_dependencies(geometric_traking_generate_messages geometric_traking_generate_messages_java)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShapes.msg" NAME_WE)
add_dependencies(geometric_traking_generate_messages_java _geometric_traking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg" NAME_WE)
add_dependencies(geometric_traking_generate_messages_java _geometric_traking_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(geometric_traking_genjava)
add_dependencies(geometric_traking_genjava geometric_traking_generate_messages_java)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS geometric_traking_generate_messages_java)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(geometric_traking
  "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShapes.msg"
  "${MSG_I_FLAGS}"
  "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometric_traking
)
_generate_msg_lisp(geometric_traking
  "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometric_traking
)

### Generating Services

### Generating Module File
_generate_module_lisp(geometric_traking
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometric_traking
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(geometric_traking_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(geometric_traking_generate_messages geometric_traking_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShapes.msg" NAME_WE)
add_dependencies(geometric_traking_generate_messages_lisp _geometric_traking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg" NAME_WE)
add_dependencies(geometric_traking_generate_messages_lisp _geometric_traking_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(geometric_traking_genlisp)
add_dependencies(geometric_traking_genlisp geometric_traking_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS geometric_traking_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(geometric_traking
  "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShapes.msg"
  "${MSG_I_FLAGS}"
  "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometric_traking
)
_generate_msg_py(geometric_traking
  "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometric_traking
)

### Generating Services

### Generating Module File
_generate_module_py(geometric_traking
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometric_traking
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(geometric_traking_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(geometric_traking_generate_messages geometric_traking_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShapes.msg" NAME_WE)
add_dependencies(geometric_traking_generate_messages_py _geometric_traking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/luca-phd/catkin_ws/src/geometric_traking/msg/TrackedShape.msg" NAME_WE)
add_dependencies(geometric_traking_generate_messages_py _geometric_traking_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(geometric_traking_genpy)
add_dependencies(geometric_traking_genpy geometric_traking_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS geometric_traking_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometric_traking)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometric_traking
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(geometric_traking_generate_messages_cpp std_msgs_generate_messages_cpp)
add_dependencies(geometric_traking_generate_messages_cpp sensor_msgs_generate_messages_cpp)
add_dependencies(geometric_traking_generate_messages_cpp pcl_msgs_generate_messages_cpp)

if(genjava_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genjava_INSTALL_DIR}/geometric_traking)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genjava_INSTALL_DIR}/geometric_traking
    DESTINATION ${genjava_INSTALL_DIR}
  )
endif()
add_dependencies(geometric_traking_generate_messages_java std_msgs_generate_messages_java)
add_dependencies(geometric_traking_generate_messages_java sensor_msgs_generate_messages_java)
add_dependencies(geometric_traking_generate_messages_java pcl_msgs_generate_messages_java)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometric_traking)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometric_traking
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(geometric_traking_generate_messages_lisp std_msgs_generate_messages_lisp)
add_dependencies(geometric_traking_generate_messages_lisp sensor_msgs_generate_messages_lisp)
add_dependencies(geometric_traking_generate_messages_lisp pcl_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometric_traking)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometric_traking\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometric_traking
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(geometric_traking_generate_messages_py std_msgs_generate_messages_py)
add_dependencies(geometric_traking_generate_messages_py sensor_msgs_generate_messages_py)
add_dependencies(geometric_traking_generate_messages_py pcl_msgs_generate_messages_py)
